_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$

Cards = require './cards'

class Home extends Cards
  className: 'app-home'

  build: ->
    super

    @gameConsoles = []
    @gameConsoles.push new App.GameConsole(prefix: "arcade", extensions: ["zip"])
    @gameConsoles.push new App.GameConsole(prefix: "nes", extensions: ["nes", "zip"])
    @gameConsoles.push new App.GameConsole(prefix: "snes", extensions: ["smc", "zip"])
    @gameConsoles.push new App.GameConsole(prefix: "n64", extensions: ["z64", "zip"])
    @gameConsoles.push new App.GameConsole(prefix: "gb", extensions: ["gb", "gbc", "zip"])
    @gameConsoles.push new App.GameConsole(prefix: "gba", extensions: ["gba", "zip"])
    @gameConsoles.push new App.GameConsole(prefix: "megadrive", extensions: ["bin", "zip"])
    @gameConsoles.push new App.GameConsole(prefix: "psx", extensions: ["cue", "img"])

    @gameConsoles = _.filter @gameConsoles, (gameConsole) ->
      gameConsole.imageExists()

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
