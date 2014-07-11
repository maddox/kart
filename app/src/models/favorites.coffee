_ = require 'underscore'
Spine._ = require 'underscore'

fsUtils = require '../lib/fs-utils'
path = require 'path'

class Favorites extends Spine.Model
  @configure "Favorites"

  constructor: ->
    super
    @games = []
    @settings = new App.Settings
    @load()

  filePath: ->
    path.join(@settings.romsPath(), 'favorites.json') if @settings.romsPath()

  load: ->
    if @filePath() && fsUtils.exists(@filePath())
      @data = require @filePath()

      for gameBlob in @data['games']
        romPath = path.join(@settings.romsPath(), gameBlob['gameConsole'], gameBlob['filename'])
        if fsUtils.exists(romPath)
          gameConsole = new App.GameConsole(prefix: gameBlob['gameConsole'])
          @games.push(new App.Game(filePath: romPath, gameConsole: gameConsole))

      _.filter @games, (game) ->
        game.imageExists()

  save: ->
    data = {'games': @games}
    fsUtils.writeSync(@filePath(), JSON.stringify(data))

  addGame: (game) ->
    @games.push(game)
    @games = @games.unique()
    @games = @games[0..5]
    @save()

  removeGame: (game) ->
    for foundGame in @games
      console.log(foundGame.filePath)
      console.log(game.filePath)
      if foundGame.filePath == game.filePath
        @games.splice(@games.indexOf(foundGame), 1)
        break

    @save()

  isFaved: (game) ->
    for foundGame in @games
      if foundGame.filePath == game.filePath
        return true
        break

    false


module.exports = Favorites
