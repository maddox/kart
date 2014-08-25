class Settings extends Spine.Model

  constructor: ->
    super
    @aspects = ['16x9', '4x3']

  clear: ->
    window.localStorage.clear()

  writeSetting: (key, value) ->
    window.localStorage.setItem(key, value)

  readSetting: (key) ->
    window.localStorage.getItem(key) || ''

  retroarchPath: ->
    @readSetting('retroarchPath')

  setRetroarchPath: (path) ->
    @writeSetting('retroarchPath', path)

  romsPath: ->
    @readSetting('romsPath')

  setRomsPath: (path) ->
    @writeSetting('romsPath', path)

  aspect: ->
    @readSetting('aspect') || '16x9'

  setAspect: (aspect) ->
    @writeSetting('aspect', aspect)

  retroMode: ->
    (@readSetting('retroMode') || false) == "true"

  setRetroMode: (retroMode) ->
    @writeSetting('retroMode', retroMode)

module.exports = Settings
