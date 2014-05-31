_ = require 'underscore'
Spine._ = require 'underscore'

fsUtils = require '../lib/fs-utils'
path = require 'path'

class GameConsole extends Spine.Model
  @configure "GameConsole", "prefix", "extensions"

  constructor: ->
    super
    @settings = new App.Settings

  path: ->
    path.join(@settings.romsPath(), @prefix)

  name: ->
    @prefix

  romPaths: ->
    fsUtils.listSync(@path(), @extensions)

  imagePath: ->
    path.join(@path(), 'image.png')

  imageExists: ->
    fsUtils.exists(@imagePath())

  games: ->
    games = _.map @romPaths(), (path) ->
      new App.Game(filePath: path, gameConsole:@)

    _.filter games, (game) ->
      game.imageExists()



module.exports = GameConsole
