_ = require 'underscore'
Spine._ = require 'underscore'

fsUtils = require '../lib/fs-utils'
path = require 'path'
http = require('http')

class Game extends Spine.Model
  @configure "Game", "filePath", "gameConsole"

  toJSON: (objects) ->
    data = {'gameConsole': @gameConsole.prefix, 'filename': @filename()}

  filename: ->
    path.basename(@filePath)

  name: ->
    path.basename(@filePath, path.extname(@filePath))

  imagePath: ->
    path.join(path.dirname(@filePath), 'images', "#{@name()}.png")

  setImage: (url, callback) ->
    self = @

    http.get url, (response) ->
      imagedata = ''
      response.setEncoding('binary')

      response.on 'data', (chunk) ->
        imagedata += chunk

      response.on 'end', () ->
        fsUtils.write(self.imagePath(), imagedata, 'binary', callback)

  imageExists: ->
    fsUtils.exists(@imagePath())

module.exports = Game
