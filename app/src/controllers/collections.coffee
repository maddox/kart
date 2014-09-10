_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$

os = require 'os'

Cards = require './cards'

class Collections extends Cards
  className: 'app-collections'

  elements:
    '.header': 'header'

  build: ->
    super
    @collections = App.Collection.all()

  showGames: (collection) ->
    app.showGames(collection)

  numberOfItems: ->
    @collections.length

  didPickCardAt: (index) ->
    @showGames(@collections[index])

  cardFor: (index) ->
    collection = @collections[index]
    data = {"imagePath": collection.imagePath(), "title": collection.name()}
    @view 'main/_card', data

module.exports = Collections
