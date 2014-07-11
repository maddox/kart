eco = require "eco"
fs  = require "fs"

Platforms = require './controllers/platforms'
Collections = require './controllers/collections'
CollectionPicker = require './controllers/collectionPicker'
Games = require './controllers/games'
Settings = require './controllers/settings'

Spine.Controller.prototype.view = (path, data) ->
  template = fs.readFileSync __dirname + "/views/#{path}.eco", "utf-8"
  eco.render template, data

class App extends Spine.Stack
  className: 'stack root'

  events:
    'click .settings-button': 'toggleSettings'

  controllers:
    platforms: Platforms
    collections: Collections
    collectionPicker: CollectionPicker
    games: Games
    settings: Settings

  default: 'platforms'

  activeController: ->
    for controller in @manager.controllers
      if controller.isActive()
        return controller
        break

  showHome: ->
    console.log('showing home')

    @platforms.update()
    @platforms.active()

  showCollection: ->
    console.log('showing collections')

    @collections.update()
    @platforms.active()

  showCollectionPicker: (game) ->
    @collectionPicker.show(game)


  toggleSettings: ->
    if @settings.isActive()
      @showHome()
    else
      @settings.active()

  showGames: (collection) ->
    @games.collection = collection
    @games.update()
    @games.active()

  keydown: (e) ->
    @activeController().keyboardNav(e)

module.exports = App
