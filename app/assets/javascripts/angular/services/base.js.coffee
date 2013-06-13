services = angular.module('mgmt.services', ['restangular'])

# TODO: use this only for GithubRestangular
services.config(['$httpProvider', ($httpProvider) ->
  $httpProvider.defaults.headers.get =
    'Accept': 'application/vnd.github.raw',
    'Content-Type': 'application/json',
    'Authorization': 'token ' + window.mgmt.token
])

services.factory('GithubRestangular', (Restangular) ->
  Restangular.withConfig((RestangularConfigurer) ->
    RestangularConfigurer.setBaseUrl('https://api.github.com')
    RestangularConfigurer.setDefaultRequestParams(
      'type': 'all',
      'per_page': 1000,
      'sort': 'updated',
      'direction': 'desc'
    )
  )
)

services.factory('Projects', (GithubRestangular) ->
  () ->
    GithubRestangular.one('orgs', window.mgmt.organization).all('repos').getList().then((projects) ->
      _.map(projects, (p) ->
        name: p.name,
        type: if p.private then 'private' else 'public'
      )
    )
)

services.factory('Project', (Restangular, GithubRestangular, $route) ->
  () ->
    Restangular.one('projects', $route.current.params.name).get(
      organization: window.mgmt.organization
    ).then((project) ->
      issuesByNumber = _.groupBy(project.issues, (i) -> i.number)
      delete project.issues
      GithubRestangular.one('repos', window.mgmt.organization).all(project.name + '/milestones').getList().then((milestones) ->
        milestones = _.groupBy(milestones, (m) -> m.number)
        project.milestones = _.map(project.milestones, (m) -> milestones[m.number][0])
        project.milestones.push({name: 'Unassigned', issues: []})
        # project.currentMilestone = milestones[project.currentMilestone.number][0]
        project
      ).then((project) ->
        GithubRestangular.one('repos', window.mgmt.organization).all(project.name + '/issues').getList().then((issues) ->
          issues = _.groupBy(issues, (i) -> if i.milestone then i.milestone.number else '-1')
          project.milestones = _.map(project.milestones, (m) ->
            m.issues = _.map(issues[m.number], (i) ->
              $.extend(i, issuesByNumber[i.number][0])
              i
            )
            m
          )
          project
        )
      )
    )
)
