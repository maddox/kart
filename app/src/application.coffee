eco = require "eco"
fs  = require "fs"

Spine.Controller.prototype.view = (path, data) ->
  template = fs.readFileSync __dirname + "/views/#{path}.eco", "utf-8"
  eco.render template, data

class App extends Spine.Controller
  constructor: ->
    super
    @log('initialized')

    @append(@main = new App.Main)


    @delay @setup, 50

  setup: ->
    @refreshElements()

  keydown: (e) ->
    @main.keyboardNav(e)

window.App = App
