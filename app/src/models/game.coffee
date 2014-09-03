_ = require 'underscore'
Spine._ = require 'underscore'
Geopattern = require 'geopattern'
Datauri = require 'datauri'

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

  defaultTitle: ->
    if !@imageExists() then @name() else ''

  image: ->
    if @imageExists()
      Datauri(@imagePath())
    else
      pattern = Geopattern.generate(@name())
      pattern.svg.setWidth(460)
      pattern.svg.setHeight(215)
      pattern.toDataUri()

  imagePath: ->
    path.join(path.dirname(@filePath), 'images', "#{@name()}.png")

  imageExists: ->
    fsUtils.exists(@imagePath())

module.exports = Game
