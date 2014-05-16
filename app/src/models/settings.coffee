class Settings extends Spine.Model

  clear: ->
    window.localStorage.clear()

  writeSetting: (key, value) ->
    window.localStorage.setItem(key, value)

  readSetting: (key) ->
    window.localStorage.getItem(key)

  retroarchPath: ->
    @readSetting('retroarchPath')

  setRetroarchPath: (path) ->
    @writeSetting('retroarchPath', path)

  romsPath: ->
    @readSetting('romsPath')

  setRomsPath: (path) ->
    @writeSetting('romsPath', path)

module.exports = Settings
