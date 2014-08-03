_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$

class Home extends Spine.Controller
  className: 'app-home'

  elements:
    '.square': 'squares'
    '.card': 'cards'

  events:
    'click .card': 'launchGame'
    'click .platforms': 'loadPlatforms'
    'click .collections': 'loadCollections'
    'mouseover .card': 'mouseover'
    'mouseleave .card': 'mouseleave'
    'mouseover .square': 'mouseover'
    'mouseleave .square': 'mouseleave'

  constructor: ->
    super

    @active @update

    @settings = new App.Settings
    @recentlyPlayed = new App.RecentlyPlayed
    @favorites = new App.Favorites
    @retroArch = new App.RetroArch

    @currentlySelectedItem = null

  render: ->
    @html @view 'main/home', @
    @selectItem(@squares.first())

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

  selectItem: (item) ->
    @deselectItem(@currentlySelectedItem) if @currentlySelectedItem
    item.addClass('selected')
    @currentlySelectedItem = item

  deselectItem: (element) ->
    $(element).removeClass('selected')

  focusGames: (item) ->
    @selectItem($('.card').first())

  focusSquares: (item) ->
    @selectItem($('.square').first())

  goUp: () ->
    @focusSquares() if @currentlySelectedItem.hasClass('card')

  goDown: () ->
    @focusGames() if @currentlySelectedItem.hasClass('square')

  goRight: () ->
    index = @currentlySelectedItem.index()

    if @currentlySelectedItem.hasClass('card')
      nextItem = @cards[index+1]
    else
      nextItem = @squares[index+1]

    @selectItem($(nextItem)) if nextItem

  goLeft: () ->
    index = @currentlySelectedItem.index()

    if @currentlySelectedItem.hasClass('card')
      nextItem = @cards[index-1]
    else
      nextItem = @squares[index-1]

    @selectItem($(nextItem)) if nextItem

  mouseover: (e) ->
    @selectItem($(e.currentTarget))

  mouseleave: (e) ->
    @deselectItem($(e.currentTarget))

  keyboardNav: (e) ->

    switch e.keyCode
      when KeyCodes.up
        @goUp()
        e.preventDefault()
      when KeyCodes.down
        @goDown()
        e.preventDefault()
      when KeyCodes.left
        @goLeft()
        e.preventDefault()
      when KeyCodes.right
        @goRight()
        e.preventDefault()
      when KeyCodes.enter
        e.preventDefault()

module.exports = Home
