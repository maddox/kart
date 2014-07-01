_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$

os = require 'os'

Cards = require './cards'

class Home extends Cards
  className: 'app-home'

  elements:
    '.header': 'header'

  build: ->
    super

    new App.RecentlyPlayed

    @gameConsoles = []

    if @settings.romsPath()
      ## platform dependent sections
      switch os.platform()
        when "darwin"
          @gameConsoles.push new App.GameConsole(prefix: "mac", extensions: ["lnk"], name: "Steam")
        when "win32"
          @gameConsoles.push new App.GameConsole(prefix: "pc", extensions: ["lnk"], name: "Steam")

      @gameConsoles.push new App.GameConsole(prefix: "arcade", extensions: ["zip"], name: "Arcade")
      @gameConsoles.push new App.GameConsole(prefix: "nes", extensions: ["nes", "zip"], name: "Nintendo Entertainment System")
      @gameConsoles.push new App.GameConsole(prefix: "snes", extensions: ["smc", "zip"], name: "Super Nintendo")
      @gameConsoles.push new App.GameConsole(prefix: "neogeo", extensions: ["zip"], name: "Neo Geo")
      @gameConsoles.push new App.GameConsole(prefix: "n64", extensions: ["z64", "zip"], name: "Nintendo 64")
      @gameConsoles.push new App.GameConsole(prefix: "gb", extensions: ["gb", "gbc", "zip"], name: "GameBoy")
      @gameConsoles.push new App.GameConsole(prefix: "gba", extensions: ["gba", "zip"], name: "GameBoy Advance")
      @gameConsoles.push new App.GameConsole(prefix: "megadrive", extensions: ["bin", "zip"], name: "Sega Genesis")
      @gameConsoles.push new App.GameConsole(prefix: "psx", extensions: ["cue", "img"], name: "Sony Playstation")

      @gameConsoles = _.filter @gameConsoles, (gameConsole) ->
        gameConsole.imageExists()

  render: ->
    super()
    @header.append('<p class="settings-button btn">Settings</p>')

  showGames: (gameConsole) ->
    app.showGames(gameConsole)

  numberOfItems: ->
    @gameConsoles.length

  didPickCardAt: (index) ->
    @showGames(@gameConsoles[index])

  cardFor: (index) ->
    gameConsole = @gameConsoles[index]
    data = {"imagePath": gameConsole.imagePath(), "title": gameConsole.name}
    @view 'main/_card', data

module.exports = Home
