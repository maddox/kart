eco = require "eco"
fs  = require "fs"

Spine.Controller.prototype.view = (path, data) ->
  # template = fs.readFileSync __dirname + "/views/#{path}.eco", "utf-8"
  # eco.render template, data

class App extends Spine.Stack
  className: 'stack root'

  controllers:
    main: App.Main
    settings: App.Settings

  default: 'main'

  showSettings: ->
    @settings.active()

  showMain: ->
    @main.active()

  # keydown: (e) ->
  #   @current.keyboardNav(e)

window.App = App
