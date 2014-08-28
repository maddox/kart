_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$

Cards = require './cards'

class Games extends Cards
  className: 'app-games'

  events:
    'click .card .overlay .game-settings .add-collection': 'addToCollection'
    'click .card .overlay .game-settings .toggle-favorite': 'toggleFavorite'
    'click .card .overlay .game-settings .edit-art': 'editArt'

  constructor: ->
    super

    @settings = new App.Settings
    @recentlyPlayed = new App.RecentlyPlayed
    @favorites = new App.Favorites
    @retroArch = new App.RetroArch

  build: ->
    super

    if @collection
      @games = @collection.games

      for game in @games
        game.bind("save", @updateGameCard)

  updateGameCard: (game) =>
    index = @games.indexOf(game)
    cardToReplace = @cards[index]
    $(cardToReplace).find('img').attr('src', game.imagePath() + "?#{new Date().getTime()}")

  launchGame: (game) ->
    @retroArch.launchGame(game)

  numberOfItems: ->
    if @games then @games.length else 0

  didPickCardAt: (index) ->
    @launchGame(@games[index])

  cardFor: (index) ->
    game = @games[index]
    data = {"imagePath": game.imagePath(), "title": game.name(), "faved": @favorites.isFaved(game)}
    @view 'main/_gameCard', data

  editArt: (e) ->
    e.stopPropagation()
    card = $(e.currentTarget).parents('.card')
    index = card.index() + (@page*@perPage)

    app.showArtEditor(@games[index])

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
