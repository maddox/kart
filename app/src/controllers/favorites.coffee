Games = require './games'

class Favorites extends Games
  className: 'app-favorites'

  build: ->
    super

    @games = @favorites.games if @favorites

module.exports = Favorites
