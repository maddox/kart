Spine = @Spine or require('./spine')
ipc = require 'ipc'

Spine.Model.Local =
  extended: ->
    @change @saveLocal
    @fetch @loadLocal

  saveLocal: ->
    data = 
      key: @className
      objects: JSON.stringify(@records)
    ipc.sendChannel 'save_data', data

  loadLocal: (options = {})->
    options.clear = true unless options.hasOwnProperty('clear')
    result = ipc.sendChannelSync 'load_data', @className
    result.map (r) ->
      r.cid = r.id
      r
    @refresh(result or [], options)

module?.exports = Spine.Model.Local
