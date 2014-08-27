_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$

fsUtils = require '../lib/fs-utils'
path = require 'path'
querystring = require("querystring");
sizeOf = require('image-size');

class Home extends Spine.Controller
  className: 'app-home'

  elements:
    '.square': 'squares'
    '.card': 'cards'
    'bodys': 'body'

  events:
    'click .card': 'cardClicked'
    'click .square': 'squareClicked'
    'mouseover .card': 'mouseover'
    'mouseleave .card': 'mouseleave'
    'mouseover .square': 'mouseover'
    'mouseleave .square': 'mouseleave'
    'click .settings-button': 'showSettings'


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

    body = $('body')

    # set the background
    custom_background_path = path.join(@settings.romsPath(), 'background.png')
    if fsUtils.exists(custom_background_path)
      @setBackgroundImage(custom_background_path)
    else
      @setBackgroundImage(path.join(__dirname, '../../images/bg-texture.png'))

    if @settings.retroMode()
      body.addClass('retro')
    else
      body.removeClass('retro')

    if @settings.aspect() == '16x9'
      body.removeClass('fourbythree')
    else if @settings.aspect() == '4x3'
      body.addClass('fourbythree')

  setBackgroundImage: (imagePath) ->
    body = $('body')
    imagePath = path.resolve(imagePath)
    imagePath = imagePath.replace(/\\/g, '\\\\') if path.sep is '\\'
    imageValue = "url('file://#{imagePath.replace(/\s/g, '%20')}')"

    return if body.css('background-image').replace(/'/g, '') == imageValue.replace(/'/g, '')

    dimensions = sizeOf(imagePath);

    if dimensions.width < 600
      backgroundRepeat = "repeat"
      backgroundSize = "auto"
    else
      backgroundRepeat = "no-repeat"
      backgroundSize = "cover"

    body.css('background-repeat', backgroundSize)
    body.css('background-size', backgroundSize)
    body.css('background-image', imageValue)

  update: ->
    @recentlyPlayed.load()
    @render()

  cardFor: (game) ->
    data = {"imagePath": game.imagePath(), "title": game.name()}
    @view 'main/_card', data

  numberOfGames: ->
    if @settings.aspect() == '16x9' then 4 else 3

  launchGame: (item) ->
    @retroArch.launchGame(@recentlyPlayed.games[item.index()])

  showSettings: ->
    app.showSettings()

  loadPlatforms: ->
    app.showPlatforms()

  loadCollections: ->
    app.showCollections()

  loadFavorites: ->
    app.showFavorites()

  pickItem: (item) ->
    if item.hasClass("card")
      @launchGame(item)
    else
      if item.hasClass("platforms")
        @loadPlatforms()
      else if item.hasClass("collections")
        @loadCollections()
      else if item.hasClass("favorites")
        @loadFavorites()


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

  cardClicked: (e) ->
    @pickItem($(e.currentTarget))

  squareClicked: (e) ->
    @pickItem($(e.currentTarget))

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
        @pickItem(@currentlySelectedItem)
        e.preventDefault()

module.exports = Home
