_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$

class ArtEditor extends Spine.Controller
  className: 'app-artEditor'

  elements:
    '.art-editor-modal': 'artEditorModal'
    '.result-name': 'resultName'

  constructor: ->
    super

    @art = []

    @render()

  render: ->
    @html @view 'main/artEditor', @

  cardFor: (url) ->
    data = {"imagePath": url, "title": ""}
    @view 'main/_card', data

  show: (game) ->

    self = @

    $.get "http://console-grid-api.herokuapp.com/search?q=#{encodeURI(game.name())}", (data) ->
      self.art = data.art
      self.render()

      self.resultName.html(data.name)

      self.artEditorModal.modal({
        overlayClose:true,
        minHeight: '60%',
        maxHeight: '60%',
        minWidth: '60%',
        maxWidth: '60%',
        onShow: (modal) ->
          $(modal.container).find('.card').click (e) ->
            card = $(e.currentTarget)
            art = self.art[card.index()]
            game.setImage art.url, () ->
              $.modal.close()
      })

module.exports = ArtEditor
