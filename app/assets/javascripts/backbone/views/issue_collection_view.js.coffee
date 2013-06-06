# Imports

Issue = window.Mgmt.Models.Issue

class IssueView extends Backbone.View

  events:
    "change .js-eh"       : "updateEstimatedHours"
    "change .js-wh"       : "updateWorkedHours"
    "click  .js-status"    : "updateStatus"
    "change .js-type"     : "updateType"

  initialize: (options) ->
    @model = new Issue(github: @model, project: options.project, pull_request: @model.pull_request.html_url)
    @model.number = @$el.data('number')
    @model.status = @$el.data('status')
    @model.id = @$el.data('id')
    @model.on('workedHoursSaveError', @onWorkedHoursSaveError)
    @listenTo(Backbone, "pull-requests:hide", @_hide_if_pull_request)
    @listenTo(Backbone, "pull-requests:show", @_show)

  # Event Handlers

  updateStatus: (event) ->
    status = $(event.target).attr("data-value")
    @model.set('status', status)
    @model.save({}, error: @onStatusSaveError)
    @$el.removeClass("accepted not_started rejected finished delivered started")
    @$el.addClass(status)

  updateType: (event) ->
    type = $(event.target).find("option:selected").val()
    @model.set('issue_type', type)
    @model.save({}, error: @onTypeSaveError)

  updateEstimatedHours: (event) ->
    @model.set('estimated_hours', $(event.target).val())
    @model.save({}, error: @onEstimatedHoursSaveError)

  updateWorkedHours: (event) ->
    @model.updateWorkedHours($(event.target).val())

  # Callbacks

  onTypeSaveError: (jqXHR, textStatus, errorThrown) =>
    Backbone.trigger('alert:message',
      title: 'Error!'
      message: "There was an error saving the type."
    )

  onStatusSaveError: (jqXHR, textStatus, errorThrown) =>
    Backbone.trigger('alert:message',
      title: 'Error!'
      message: "There was an error saving the status."
    )

  onWorkedHoursSaveError: (jqXHR, textStatus, errorThrown) =>
    Backbone.trigger('alert:message',
      title: 'Error!'
      message: "There was an error saving the worked hours."
    )

  onEstimatedHoursSaveError: (jqXHR, textStatus, errorThrown) =>
    Backbone.trigger('alert:message',
      title: 'Error!'
      message: "There was an error saving the estimated hours."
    )

  # View Methods

  render: ->
    @$('.js-issue-title').attr("title", @model.github.title)
    @$('.js-issue-title').html(@issue_title)
    @$('.js-issue-link').attr('href', @model.github.html_url)
    @$('.js-timeago').timeago()
    @model.set('estimated_hours', @$('.js-eh').val())
    @model.set('worked_hours', @$('.js-wh').val())

  issue_title: =>
    title = @model.github.title
    title = title.substring(0, 48) + " ..." if title.length > 49
    title

  _hide_if_pull_request: =>
    if @model.get('pull_request') isnt null
      $(@el).hide()

  _show: =>
    $(@el).show()    

class IssueCollectionView extends Backbone.View

  initialize: (options) ->
    @project = options.project

  render: ->
    for issue in @model
      issueView = new IssueView 
        project: @project
        el: @$("[data-number=#{issue.number}]")
        model: issue
      issueView.render()

# Exports

window.Mgmt.Views.IssueView = IssueView
window.Mgmt.Views.IssueCollectionView = IssueCollectionView