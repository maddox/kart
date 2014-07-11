Spine = require './lib/spine/spine'
require './lib/spine/list'
require './lib/spine/local'
require './lib/spine/route'
require './lib/spine/manager'
require './lib/spine/relation'

window.Spine = Spine

require './lib/hotkeys'
require './lib/extensions'

window.App = require './application'

App.Game = require './models/game'
App.GameConsole = require './models/gameConsole'
App.Collection = require './models/collection'
App.Settings = require './models/settings'
App.RecentlyPlayed = require './models/recentlyPlayed'

$ =>
  $('body').addClass 'loaded'


  window.app = new App
    el: document.body

  require './events'
