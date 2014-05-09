Spine = require './lib/spine/spine'
require './lib/spine/list'
require './lib/spine/local'
require './lib/spine/route'
require './lib/spine/manager'
require './lib/spine/relation'

window.Spine = Spine

require './lib/hotkeys'

Game = require './models/game'
GameConsole = require './models/gameConsole'

require './application'

App.Game = Game
App.GameConsole = GameConsole

$ =>
  $('body').addClass 'loaded'

  require './controllers/main'

  window.app = new App
    el: document.body

  require './events'

  # Spine.Route.setup()
