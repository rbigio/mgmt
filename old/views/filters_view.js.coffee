class FiltersView extends Backbone.View

  events:
    "click #pull-requests .js-on"       : "showPullRequest"
    "click #pull-requests .js-off"      : "hidePullRequest"

  hidePullRequest: =>
    Backbone.trigger('pull-requests:hide')

  showPullRequest: =>
    Backbone.trigger('pull-requests:show')

# Export

window.Mgmt.Views.FiltersView = FiltersView