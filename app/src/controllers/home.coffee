_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$

class Home extends Spine.Controller
  className: 'app-home'

  elements:
    '.browse': 'browse'
    '.recently-played': 'recentlyPlayed'

  events:
    'mouseover .card': 'mouseover'
    'mouseleave .card': 'mouseleave'

  constructor: ->
    super

    @settings = new App.Settings
    @recentlyPlayed = new App.RecentlyPlayed
    @favorites = new App.Favorites

    @currentlySelectedItem = null

    @render()

  render: ->
    @html @view 'main/home', @

  cardFor: (game) ->
    data = {"imagePath": game.imagePath(), "title": game.name(), "faved": @favorites.isFaved(game)}
    @view 'main/_gameCard', data

  numberOfGames: ->
    if @settings.aspect() == '16x9' then 4 else 3

  selectItem: (element) ->
    item = $(element)
    @deselectItem(item) if @currentlySelectedItem
    item.addClass('selected')
    @currentlySelectedItem = item

  deselectItem: (element) ->
    $(element).removeClass('selected')

  mouseover: (e) ->
    @selectItem(e.currentTarget)

  mouseleave: (e) ->
    @deselectItem(e.currentTarget)


module.exports = Home
