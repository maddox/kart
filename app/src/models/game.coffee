_ = require 'underscore'
Spine._ = require 'underscore'

fsUtils = require '../lib/fs-utils'
path = require 'path'

class Game extends Spine.Model
  @configure "Game", "filePath", "gameConsole"

  toJSON: (objects) ->
    data = {'gameConsole': @gameConsole.prefix, 'filename': @filename()}

  filename: ->
    path.basename(@filePath)

  name: ->
    path.basename(@filePath, path.extname(@filePath))

  imagePath: ->
    if @imageExists()
      @customCardPath()
    else
      @gameConsole.gameCardPath()

  customCardPath: ->
    path.join(path.dirname(@filePath), 'images', "#{@name()}.png")

  imageExists: ->
    fsUtils.exists(@customCardPath())

module.exports = Game
