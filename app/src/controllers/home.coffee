_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$

class Home extends Spine.Controller
  className: 'app-home'

  elements:
    '.browse': 'browse'
    '.recently-played': 'recentlyPlayed'

  constructor: ->
    super

    @settings = new App.Settings
    @recentlyPlayed = new App.RecentlyPlayed
    @favorites = new App.Favorites

    @render()

  render: ->
    @html @view 'main/home', @

  cardFor: (game) ->
    data = {"imagePath": game.imagePath(), "title": game.name(), "faved": @favorites.isFaved(game)}
    @view 'main/_gameCard', data

  numberOfGames: ->
    if @settings.aspect() == '16x9' then 4 else 3

module.exports = Home
