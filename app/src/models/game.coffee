_ = require 'underscore'
Spine._ = require 'underscore'

fsUtils = require '../lib/fs-utils'
path = require 'path'

class Game extends Spine.Model
  @configure "Game", "filePath", "gameConsole"

  filename: ->
    path.basename(@filePath)

  name: ->
    path.basename(@filePath, path.extname(@filePath))

  imagePath: ->
    path.join(path.dirname(@filePath), 'images', "#{@name()}.png")

  imageExists: ->
    fsUtils.exists(@imagePath())

module.exports = Game
