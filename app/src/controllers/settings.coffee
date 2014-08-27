_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$

fsUtils = require '../lib/fs-utils'
dialog = require('remote').require('dialog')

class Settings extends Spine.Controller
  className: 'app-settings'

  elements:
    '#retroarch_path': 'retroarchPathInput'
    '#roms_path': 'romsPathInput'
    '#retro_mode': 'retroMode'

  events:
    'click #retroarch_path_button': 'browseRetroarchPath'
    'click #roms_path_button': 'browseRomsPath'
    'change #aspect': 'setAspect'
    'change #retro-mode': 'toggleRetroMode'

  constructor: ->
    super

    @settings = new App.Settings

    @render()
    @build()

  render: ->
    @html @view 'main/settings', @

  build: ->
    @retroarchPathInput.html(@settings.retroarchPath())
    @romsPathInput.html(@settings.romsPath())

  browseRetroarchPath: (e) ->
    path = dialog.showOpenDialog({ title: 'Retroarch Path', properties: [ 'openDirectory' ]})
    if path
      @settings.setRetroarchPath(path)
      @build()

  browseRomsPath: (e) ->
    path = dialog.showOpenDialog({ title: 'Roms Path', properties: [ 'openDirectory' ]})
    if path
      @settings.setRomsPath(path)
      @build()

  setAspect: (e) ->
    @settings.setAspect($(e.currentTarget).val())

  toggleRetroMode: (e) ->
    @settings.setRetroMode($(e.currentTarget).is(':checked'))

  keyboardNav: (e) ->

    switch e.keyCode
      when KeyCodes.backspace
        app.showHome()
        e.preventDefault()
      when KeyCodes.esc
        app.showHome()
        e.preventDefault()

module.exports = Settings
