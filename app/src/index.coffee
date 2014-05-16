Spine = require './lib/spine/spine'
require './lib/spine/list'
require './lib/spine/local'
require './lib/spine/route'
require './lib/spine/manager'
require './lib/spine/relation'

window.Spine = Spine

require './lib/hotkeys'

window.App = require './application'

App.Game = require './models/game'
App.GameConsole = require './models/gameConsole'

$ =>
  $('body').addClass 'loaded'

  window.app = new App
    el: document.body

  require './events'
