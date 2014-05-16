eco = require "eco"
fs  = require "fs"

Main = require './controllers/main'
Settings = require './controllers/settings'

Spine.Controller.prototype.view = (path, data) ->
  template = fs.readFileSync __dirname + "/views/#{path}.eco", "utf-8"
  eco.render template, data

class App extends Spine.Stack
  className: 'stack root'

  controllers:
    main: Main
    settings: Settings

  default: 'main'

  showSettings: ->
    @settings.active()

  showMain: ->
    @main.active()

  # keydown: (e) ->
  #   @current.keyboardNav(e)

module.exports = App
