_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$


class CollectionPicker extends Spine.Controller
  className: 'app-collectionPicker'

  elements:
    '.collections-modal': 'collectionsModal'

  constructor: ->
    super

    @collections = App.Collection.all()
    @render()

  render: ->
    @html @view 'main/collectionPicker', @

  cardFor: (collection) ->
    data = {"imagePath": collection.imagePath(), "title": collection.name()}
    @view 'main/_card', data

  show: (game) ->
    console.log(game)
    self = @

    @collectionsModal.modal({
      overlayClose:true,
      minHeight: '60%',
      maxHeight: '60%',
      minWidth: '60%',
      maxWidth: '60%',
      onShow: (modal) ->
        $(modal.container).find('.card').click (e) ->
          card = $(e.currentTarget)
          collection = self.collections[card.index()]
          collection.addGame(game)
          $.modal.close()
    })

module.exports = CollectionPicker
