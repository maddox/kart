_ = require 'underscore'
Spine._ = require 'underscore'

fsUtils = require '../lib/fs-utils'

class GameConsole extends Spine.Model
  @configure "GameConsole", "prefix", "extensions"

  constructor: ->
    super
    @settings = new App.Settings

  basePath: ->
    @settings.romsPath()

  path: ->
    "#{@basePath()}/#{@prefix}"

  name: ->
    @prefix

  romPaths: ->
    fsUtils.listSync(@path(), @extensions)

  imagePath: ->
    "#{@path()}/image.png"

  imageExists: ->
    fsUtils.exists(@imagePath())

  games: ->
    games = _.map @romPaths(), (path) ->
      new App.Game(path: path)

    _.filter games, (game) ->
      game.imageExists()



module.exports = GameConsole
