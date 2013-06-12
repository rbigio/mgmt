class AlertView extends Backbone.View

  events:
    "click button" : "hideAlert"

  initialize: (options) ->
    @listenTo(Backbone, "alert:message", @displayMessage)

  displayMessage: (options) =>
    @$('.js-title').html(options.title)
    @$('.js-message').html(options.message)
    @$el.show()
    setTimeout(=>
      @$el.fadeOut('slow')
    , 4000)

  hideAlert: (event) ->
    @$el.fadeOut('slow')

# Export

window.Mgmt.Views.AlertView = AlertView