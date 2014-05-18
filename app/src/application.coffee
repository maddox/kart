eco = require "eco"
fs  = require "fs"

Games = require './controllers/games'
Settings = require './controllers/settings'

Spine.Controller.prototype.view = (path, data) ->
  template = fs.readFileSync __dirname + "/views/#{path}.eco", "utf-8"
  eco.render template, data

class App extends Spine.Stack
  className: 'stack root'

  controllers:
    games: Games
    settings: Settings

  default: 'games'

  activeController: ->
    for controller in @manager.controllers
      if controller.isActive()
        return controller
        break

  showSettings: ->
    @settings.active()

  showGames: ->
    @games.update()
    @games.active()

  keydown: (e) ->
    @activeController().keyboardNav(e)

module.exports = App
