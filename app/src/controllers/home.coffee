_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$

class Home extends Spine.Controller
  className: 'app-home'

  events:
    'click .card': 'launchGame'
    'click .platforms': 'loadPlatforms'
    'click .collections': 'loadCollections'
    'mouseover .card': 'mouseover'
    'mouseleave .card': 'mouseleave'

  constructor: ->
    super

    @settings = new App.Settings
    @recentlyPlayed = new App.RecentlyPlayed
    @favorites = new App.Favorites
    @retroArch = new App.RetroArch

    @currentlySelectedItem = null

  render: ->
    @html @view 'main/home', @

  update: ->
    @recentlyPlayed.load()
    @render()

  cardFor: (game) ->
    data = {"imagePath": game.imagePath(), "title": game.name(), "faved": @favorites.isFaved(game)}
    @view 'main/_gameCard', data

  numberOfGames: ->
    if @settings.aspect() == '16x9' then 4 else 3

  launchGame: (e) ->
    card = $(e.currentTarget)
    @retroArch.launchGame(@recentlyPlayed.games[card.index()])

  loadPlatforms: (e) ->
    card = $(e.currentTarget)
    app.showPlatforms()

  loadCollections: (e) ->
    card = $(e.currentTarget)
    app.showCollections()

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
