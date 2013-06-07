class Milestone extends Backbone.Model

  defaults:
    estimated_hours: 0
    client_estimated_hours: 0

  urlRoot: ->
    "/projects/#{@project}/milestones"

  initialize: (options)->
    @project = options.project
    @github = options.github

# Exports

window.Mgmt.Models.Milestone = Milestone