_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$

fsUtils = require '../lib/fs-utils'
path = require 'path'
os = require 'os'
shell = require 'shell'

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

  build: ->
    super

    @games = @collection.games if @collection

  launchGame: (game) ->
    switch os.platform()
      when "darwin"
        if game.gameConsole.prefix == "mac"
          command = game.filePath
        else
          command = path.join(@settings.retroarchPath(), 'bin', 'retroarch')
      when "win32"
        if game.gameConsole.prefix == "pc"
          command = game.filePath
        else
          command = path.join(@settings.retroarchPath(), 'retroarch.exe')
      else
        alert("Sorry, this operating system isn't supported.")
        return

    if game.gameConsole.prefix != "pc" && game.gameConsole.prefix != "mac"
      configPath = path.join(__dirname, '..', '..', 'configs')
      options = ["--config", path.join(configPath, os.platform(), 'kart.cfg'),
           "--appendconfig", path.join(configPath, os.platform(), "#{game.gameConsole.prefix}.cfg"),
           path.normalize(game.filePath)]

    @recentlyPlayed.addGame(game)

    if options
      {spawn} = require 'child_process'
      ls = spawn command, options
      # receive all output and process
      ls.stdout.on 'data', (data) -> console.log data.toString().trim()
      # receive error messages and process
      ls.stderr.on 'data', (data) -> console.log data.toString().trim()
    else
      shell.openItem(game.filePath);

  numberOfItems: ->
    if @games then @games.length else 0

  didPickCardAt: (index) ->
    @launchGame(@games[index])

  cardFor: (index) ->
    game = @games[index]
    data = {"imagePath": game.imagePath(), "title": game.name(), "faved": @favorites.isFaved(game)}
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

  keyboardNav: (e) ->
    super

    switch e.keyCode
      when KeyCodes.backspace
        app.back()
        e.preventDefault()
      when KeyCodes.esc
        app.back()
        e.preventDefault()


module.exports = Games
