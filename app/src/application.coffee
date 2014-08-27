eco = require "eco"
fs  = require "fs"

Home = require './controllers/home'
Platforms = require './controllers/platforms'
Collections = require './controllers/collections'
Favorites = require './controllers/favorites'
CollectionPicker = require './controllers/collectionPicker'
Games = require './controllers/games'
Settings = require './controllers/settings'

Spine.Controller.prototype.view = (path, data) ->
  template = fs.readFileSync __dirname + "/views/#{path}.eco", "utf-8"
  eco.render template, data

class App extends Spine.Stack
  className: 'stack root'

  controllers:
    home: Home
    platforms: Platforms
    collections: Collections
    favorites: Favorites
    collectionPicker: CollectionPicker
    games: Games
    settings: Settings

  default: 'home'

  constructor: ->
    super

    @history = []
    @el.append(@view('main/_controlInfo'))
    $('.control-info').show()

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

  showPlatforms: ->
    @platforms.update()
    @goTo(@platforms)

  showCollections: ->
    @collections.update()
    @goTo(@collections)

  showFavorites: ->
    @favorites.update()
    @goTo(@favorites)

  showCollectionPicker: (game) ->
    @collectionPicker.show(game)

  toggleSettings: ->
    if @settings.isActive() then @back() else @goTo(@settings)

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
