_ = require 'underscore'
Spine._ = require 'underscore'

fsUtils = require '../lib/fs-utils'

class Game extends Spine.Model
  @configure "Game", "path"

  filename: ->
    parts = @path.split('/')
    parts[parts.length-1]

  gameConsole: ->
    parts = @path.split('/')
    parts[parts.length-2]

  baseName: ->
    parts = @filename().split('.')
    parts.pop()
    parts.join('.')

  name: ->
    @baseName().replace /\./g, ' '

  basePath: ->
    parts = @path.split('/')
    parts.pop()
    parts.join('/')

  imagePath: ->
    "#{@basePath()}/images/#{@baseName()}.png"

  imageExists: ->
    fsUtils.exists(@imagePath())

module.exports = Game
