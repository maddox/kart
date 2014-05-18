_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$

fsUtils = require '../lib/fs-utils'

class Home extends Spine.Controller
  className: 'app-home'

  elements:
    '.cards .card': 'cards'

  events:
    'click .card': 'click'
    'click .settings-button': 'showSettings'
    'mouseover .card': 'mouseover'
    'mouseleave .card': 'mouseleave'

  constructor: ->
    super

    @settings = new App.Settings

    @gameConsoles = []

    @cardMatrix = []
    @currentlySelectedCard = null

    @rows = 3
    @perRow = 4
    @perPage = @rows * @perRow

    @numberOfPages = 0
    @page = 0
    @x = -1
    @y = -1

    @update()

  build: ->
    @gameConsoles = []
    @gameConsoles.push new App.GameConsole(prefix: "nes", extensions: ["nes", "zip"])
    @gameConsoles.push new App.GameConsole(prefix: "snes", extensions: ["smc", "zip"])
    @gameConsoles.push new App.GameConsole(prefix: "gb", extensions: ["gb", "gbc", "zip"])
    @gameConsoles.push new App.GameConsole(prefix: "gba", extensions: ["gba", "zip"])
    @gameConsoles.push new App.GameConsole(prefix: "megadrive", extensions: ["bin", "zip"])

    _.filter @gameConsoles, (gameConsole) ->
      gameConsole.imageExists()

    @numberOfPages = parseInt(@gameConsoles.length / @perPage)
    @numberOfPages++ if @gameConsoles.length % @perPage

  render: ->
    @html @view 'main/home', @
    @setSelected(0,0);

  update: ->
    @build()
    @render();

  showSettings: ->
    app.showSettings()

  showGames: (gameConsole) ->
    app.showGames(gameConsole)

  click: (e) ->
    e.preventDefault()
    card = $(e.currentTarget)

    gameConsole = @gameConsoles[card.index()]
    @showGames(gameConsole)

  selectCard: (card) ->
    @currentlySelectedCard.removeClass('selected') if @currentlySelectedCard
    $(card).addClass('selected')

  deselectCard: (card) ->
    $(card).removeClass('selected')

  setSelected: (i, j) ->

    # check direction for scrolling later
    if j > @y
      direction = 'right'
    else if j < @y
      direction = 'left'


    # max up at the top
    if i < 0
      i = 0
    # max down at the bottom
    if i >= @rows
      i = @rows-1

    # max left on first page
    if j < 0 && @page == 0
      j = 0

    # go back a page and place on far right column
    if j < 0 && @page > 0
      j = @perRow-1
      @page -= 1


    # advancing a page to the right
    if j >= @perRow
      # max right to the far right on the last page
      if j >= @page+1 >= @numberOfPages
        j = 3
      # advance a page
      else
        j = 0
        @page += 1


        # check to see if there are contents on that row
        adjustedI = @page*@rows + i
        index = (@perRow * adjustedI + j)
        # no items on that row, pop to the top
        if index >= @gameConsoles.length
          i = 0

    # adjust i for what page it's on
    # don't forget, according to the DOM, the pages are
    # UNDER each other
    adjustedI = @page*@rows + i
    index = (@perRow * adjustedI + j)

    if index < @gameConsoles.length
      # set selected items
      @currentlySelectedCard.removeClass('selected') if @currentlySelectedCard
      @currentlySelectedCard = $(@cards[index])
      @currentlySelectedCard.addClass('selected')



      # check if card is visible, if it isn't scroll to it
      if !@currentlySelectedCard.visible()
        scrollAmount = @currentlySelectedCard.width() + 50
        if direction == 'left'
          scrollOption = "-=#{scrollAmount}px"
        else
          scrollOption = "+=#{scrollAmount}px"

        $.scrollTo(scrollOption, 150, {easing:'swing'})


      # save these for later
      @x = i;
      @y = j;


  mouseover: (e) ->
    card = $(e.currentTarget)
    @selectCard(card)

  mouseleave: (e) ->
    card = $(e.currentTarget)
    @deselectCard(card)

  keyboardNav: (e) ->

    switch e.keyCode
      when KeyCodes.up
        @setSelected(@x-1,@y);
        e.preventDefault()
      when KeyCodes.down
        @setSelected(@x+1,@y);
        e.preventDefault()
      when KeyCodes.left
        @setSelected(@x,@y-1);
        e.preventDefault()
      when KeyCodes.right
        @setSelected(@x,@y+1);
        e.preventDefault()
      when KeyCodes.enter
        @showGames(@gameConsoles[$(@currentlySelectedCard).index()  + (@page*12) ])
        e.preventDefault()
      when KeyCodes.esc
        e.preventDefault()

module.exports = Home
