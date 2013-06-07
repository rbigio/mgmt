# Imports

Milestone = window.Mgmt.Models.Milestone

class MilestoneView extends Backbone.View

  initialize: (options) ->
    @model = new Milestone(github: @model, project: options.project)
    @model.number = @$el.data('number')
    @model.id = @$el.data('id')

  # View Methods

  render: ->
    @$('.js-milestone-title').attr("title", @model.github.milestone_title)
    @$('.js-milestone-due_date').html(@model.github.end_date)
    @$('.js-milestone-title').html(@milestone_title)
    @$('.js-milestone-link').attr('href', @model.github.html_url)
    @model.set('start_date', @$('.js-sd').val())
    @model.set('estimated_hours', @$('.js-eh').val())
    @model.set('client_estimated_hours', @$('.js-ceh').val())

  milestone_title: =>
    title = @model.github.title
    title = title.substring(0, 48) + " ..." if title.length > 49
    title

class MilestoneCollectionView extends Backbone.View

  initialize: (options) ->
    @project = options.project

  render: ->
    for milestone in @model
      milestoneView = new MilestoneView
        project: @project
        el: @$("[data-milestone-number=#{milestone.number}]")
        model: milestone
      milestoneView.render()

# Exports

window.Mgmt.Views.MilestoneView = MilestoneView
window.Mgmt.Views.MilestoneCollectionView = MilestoneCollectionView
