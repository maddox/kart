_ = require 'underscore'
Spine._ = require 'underscore'

fsUtils = require '../lib/fs-utils'

class GameConsole extends Spine.Model
  @configure "GameConsole", "prefix", "extensions"

  basePath: ->
    window.localStorage.romsPath

  romPaths: ->
    fsUtils.listSync("#{@basePath()}/#{@prefix}", @extensions)

  games: ->
    games = _.map @romPaths(), (path) ->
      new App.Game(path: path)

    _.filter games, (game) ->
      game.imageExists()



module.exports = GameConsole
