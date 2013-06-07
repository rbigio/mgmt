class Issue extends Backbone.Model

  defaults:
    estimated_hours: 0
    worked_hours: 0

  urlRoot: ->
    "/projects/#{@project}/issues"
  
  paramRoot: "issue"

  initialize: (options)->
    @project = options.project
    @github = options.github

  updateWorkedHours: (workedHours) ->
    old = parseFloat(@get('worked_hours'))
    diff = workedHours - old
    $.ajax(
      type: 'POST'
      url: "#{@url()}/log_worked_hours"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify(worked_hours: diff)
      success: =>
        @set('worked_hours', workedHours)
        @trigger('workedHoursSuccessfullSave')
      error: (jqXHR, textStatus, errorThrown) =>
        @trigger('workedHoursSaveError', jqXHR, textStatus, errorThrown)
    )

# Exports

window.Mgmt.Models.Issue = Issue