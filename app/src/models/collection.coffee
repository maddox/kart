_ = require 'underscore'
Spine._ = require 'underscore'

fsUtils = require '../lib/fs-utils'
path = require 'path'

class Collection extends Spine.Model
  @configure "Collection", "path"

  @path: ->
    settings = new App.Settings
    return null if !settings.romsPath()
    path.join(settings.romsPath(), 'collections')

  @all: ->
    return [] if @path() == null
    collections = _.map fsUtils.listSync(@path()), (path) ->
      new App.Collection(path: path)

    _.filter collections, (collection) ->
      collection.isValid()

  constructor: ->
    super
    @games = []
    @settings = new App.Settings
    @loadFromFile()

  isValid: ->
    fsUtils.isDirectorySync(@path) &&
    fsUtils.exists(@imagePath())

  name: ->
    path.basename(@path)

  imagePath: ->
    path.join(@path, "image.png")

  filePath: ->
    path.join(@path, 'games.json')

  loadFromFile: ->
    if fsUtils.exists(@filePath())
      data = require @filePath()
      for gameBlob in data['games']
        romPath = path.join(@settings.romsPath(), gameBlob['gameConsole'], gameBlob['filename'])
        if fsUtils.exists(romPath)
          gameConsole = new App.GameConsole(prefix: gameBlob['gameConsole'])
          @games.push(new App.Game(filePath: romPath, gameConsole: gameConsole))

      _.filter @games, (game) ->
        game.imageExists()


  saveToFile: ->
    data = {'games': @games}
    fsUtils.writeSync(@filePath(), JSON.stringify(data))

  addGame: (game) ->
    @games.push(game)
    @games = @games.unique()
    @saveToFile()


module.exports = Collection
