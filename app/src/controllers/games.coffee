_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$

fsUtils = require '../lib/fs-utils'

Cards = require './cards'

class Games extends Cards
  className: 'app-games'

  constructor: ->
    super

    @settings = new App.Settings

  build: ->
    super

    @games = @gameConsole.games() if @gameConsole

  launchGame: (game) ->
    command = "#{@settings.retroarchPath()}/bin/retroarch"
    options = ["--config", "#{@settings.retroarchPath()}/configs/all/retroarch.cfg", "--appendconfig", "#{@settings.retroarchPath()}/configs/#{game.gameConsole()}/retroarch.cfg", game.path]

    {spawn} = require 'child_process'
    ls = spawn command, options
    # receive all output and process
    ls.stdout.on 'data', (data) -> console.log data.toString().trim()
    # receive error messages and process
    ls.stderr.on 'data', (data) -> console.log data.toString().trim()

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
      when KeyCodes.esc
        app.showHome()
        e.preventDefault()


module.exports = Games
