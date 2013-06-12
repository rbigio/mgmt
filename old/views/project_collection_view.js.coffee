class ProjectCollectionView extends Backbone.View

  # Public Methods

  projectGroupTemplate: JST['backbone/templates/projects/item_group']
  projectItem: JST['backbone/templates/projects/item']

  initialize: (options) ->
    @projects = options.projects
    @privacy = options.privacy

    # DOM Cache
    @$projectList = @$('.js-project-list')

  render: ->
    i = 0
    @$projectList.html("")
    for project in @projects when @_projectShouldBeListed(project)
      do (project) =>
        @$projectList.append(@projectGroupTemplate()) if i % 4 is 0
        @$(".js-project-group:last").append(@projectItem(projectName: project.name))
        i++
    @$(".js-project-count").text(i)

  # Private Methods

  _projectShouldBeListed: (project) ->
    (project.private and @privacy is 'private') or (not project.private and @privacy is 'public')

# Exports

window.Mgmt.Views.ProjectCollectionView = ProjectCollectionView