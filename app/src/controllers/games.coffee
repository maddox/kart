_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$

Cards = require './cards'

class Games extends Cards
  className: 'app-games'

  events:
    'click .card .overlay .game-settings .add-collection': 'addToCollection'
    'click .card .overlay .game-settings .toggle-favorite': 'toggleFavorite'

  constructor: ->
    super

    @settings = new App.Settings
    @recentlyPlayed = new App.RecentlyPlayed
    @favorites = new App.Favorites
    @retroArch = new App.RetroArch

  build: ->
    super

    @games = @collection.games if @collection

  launchGame: (game) ->
    @retroArch.launchGame(game)

  numberOfItems: ->
    if @games then @games.length else 0

  didPickCardAt: (index) ->
    @launchGame(@games[index])

  cardFor: (index) ->
    game = @games[index]
    data = {"image": game.image(), "title": game.name(), "faved": @favorites.isFaved(game), "imageExists": game.imageExists()}
    @view 'main/_gameCard', data

  addToCollection: (e) ->
    e.stopPropagation()
    card = $(e.currentTarget).parents('.card')
    index = card.index() + (@page*@perPage)

    app.showCollectionPicker(@games[index])

  toggleFavorite: (e) ->
    e.stopPropagation()
    favButton = $(e.currentTarget)
    card = $(e.currentTarget).parents('.card')
    index = card.index() + (@page*@perPage)

    if favButton.hasClass('fa-heart-o')
      @favorites.addGame(@games[index])
      favButton.removeClass('fa-heart-o').addClass('fa-heart')
    else
      @favorites.removeGame(@games[index])
      favButton.removeClass('fa-heart').addClass('fa-heart-o')

module.exports = Games
