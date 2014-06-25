_ = require 'underscore'
Spine._ = require 'underscore'

fsUtils = require '../lib/fs-utils'
path = require 'path'

class RecentlyPlayed extends Spine.Model
  @configure "RecentlyPlayed"

  constructor: ->
    super
    @games = []
    @settings = new App.Settings
    @load()

  filePath: ->
    path.join(@settings.romsPath(), 'recently-played.json')

  load: ->
    if fsUtils.exists(@filePath())
      @data = require @filePath()
    else
      console.log('no recently played')


      for gameBlob in @data['games']
        romPath = path.join(@settings.romsPath(), gameBlob['gameConsole'], gameBlob['filename'])
        if fsUtils.exists(romPath)
          gameConsole = new App.GameConsole(prefix: gameBlob['gameConsole'])
          @games.push(new App.Game(filePath: romPath, gameConsole: gameConsole))

      _.filter @games, (game) ->
        game.imageExists()

module.exports = RecentlyPlayed
