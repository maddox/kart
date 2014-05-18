_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$

Cards = require './cards'

class Home extends Cards
  className: 'app-home'

  events:
    'click .settings-button': 'showSettings'

  constructor: ->
    super

    @settings = new App.Settings

  build: ->
    super

    @gameConsoles = []
    @gameConsoles.push new App.GameConsole(prefix: "nes", extensions: ["nes", "zip"])
    @gameConsoles.push new App.GameConsole(prefix: "snes", extensions: ["smc", "zip"])
    @gameConsoles.push new App.GameConsole(prefix: "gb", extensions: ["gb", "gbc", "zip"])
    @gameConsoles.push new App.GameConsole(prefix: "gba", extensions: ["gba", "zip"])
    @gameConsoles.push new App.GameConsole(prefix: "megadrive", extensions: ["bin", "zip"])

    _.filter @gameConsoles, (gameConsole) ->
      gameConsole.imageExists()

  showSettings: ->
    app.showSettings()

  showGames: (gameConsole) ->
    app.showGames(gameConsole)

  numberOfItems: ->
    @gameConsoles.length

  didPickCardAt: (index) ->
    @showGames(@gameConsoles[index])

  cardFor: (index) ->
    gameConsole = @gameConsoles[index]
    data = {"imagePath": gameConsole.imagePath(), "title": gameConsole.name()}
    @view 'main/_card', data

module.exports = Home
