_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$

fsUtils = require '../lib/fs-utils'
path = require 'path'
os = require 'os'
shell = require 'shell'

Cards = require './cards'

class Games extends Cards
  className: 'app-games'

  constructor: ->
    super

    @settings = new App.Settings
    @recentlyPlayed = new App.RecentlyPlayed

  build: ->
    super

    @games = @gameConsole.games() if @gameConsole

  launchGame: (game) ->

    switch os.platform()
      when "darwin"
        if game.gameConsole.prefix == "mac"
          command = game.filePath
        else
          command = path.join(@settings.retroarchPath(), 'bin', 'retroarch')
      when "win32"
        if game.gameConsole.prefix == "pc"
          command = game.filePath
        else
          command = path.join(@settings.retroarchPath(), 'retroarch.exe')
      else
        alert("Sorry, this operating system isn't supported.")
        return

    if game.gameConsole.prefix != "pc" && game.gameConsole.prefix != "mac"
      configPath = path.join(__dirname, '..', '..', 'configs')
      options = ["--config", path.join(configPath, os.platform(), 'kart.cfg'),
           "--appendconfig", path.join(configPath, os.platform(), "#{@gameConsole.prefix}.cfg"),
           path.normalize(game.filePath)]

    @recentlyPlayed.addGame(game)

    if options
      {spawn} = require 'child_process'
      ls = spawn command, options
      # receive all output and process
      ls.stdout.on 'data', (data) -> console.log data.toString().trim()
      # receive error messages and process
      ls.stderr.on 'data', (data) -> console.log data.toString().trim()
    else
      shell.openItem(game.filePath);

  numberOfItems: ->
    if @games then @games.length else 0

  didPickCardAt: (index) ->
    @launchGame(@games[index])

  cardFor: (index) ->
    game = @games[index]
    data = {"imagePath": game.imagePath(), "title": game.name()}
    @view 'main/_card', data

  keyboardNav: (e) ->
    super

    switch e.keyCode
      when KeyCodes.backspace
        app.showHome()
        e.preventDefault()
      when KeyCodes.esc
        app.showHome()
        e.preventDefault()


module.exports = Games
