eco = require "eco"
fs  = require "fs"

Home = require './controllers/home'
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
    home: Home
    platforms: Platforms
    collections: Collections
    collectionPicker: CollectionPicker
    games: Games
    settings: Settings

  default: 'home'

  constructor: ->
    super

    @history = []

  activeController: ->
    for controller in @manager.controllers
      if controller.isActive()
        return controller
        break

  goTo: (controller) ->
    @history.push(@activeController())
    controller.active()

  back: ->
    return if @history.length == 0

    controller = @history.pop()
    controller.active()

  showHome: ->
    @platforms.update()
    @goTo(@platforms)

  showCollection: ->
    @collections.update()
    @goTo(@collections)

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
    @goTo(@games)

  keydown: (e) ->
    switch e.keyCode
      when KeyCodes.backspace
        @back()
        e.preventDefault()
      when KeyCodes.esc
        @back()
        e.preventDefault()
      else
        @activeController().keyboardNav(e)

module.exports = App
