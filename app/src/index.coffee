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


require './controllers/main'
require './controllers/settings'


App.Game = Game
App.GameConsole = GameConsole

$ =>
  $('body').addClass 'loaded'

  require './application'


  window.app = new App
    el: document.body

  # app.showMain()

  console.log(app.main.isActive())


  require './events'

  # Spine.Route.setup()
