# Imports

IssueCollectionView = window.Mgmt.Views.IssueCollectionView
FiltersView = window.Mgmt.Views.FiltersView

class IssuesView extends Backbone.View

  initialize: (options) ->
    @project = options.project
    @listenTo(Backbone, "issues:response", @displayIssues)
    @el = $('.container')
    @filtersView = new FiltersView
      el: $('.filters')

  displayIssues: (options) =>
   issueCollection = new IssueCollectionView
      project: @project
      model: options.issues
      el: $("#issues")
    issueCollection.render()

# Export

window.Mgmt.Views.IssuesView = IssuesView