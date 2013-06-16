services = angular.module('mgmt.services')

services.factory('UpdateIssue', (Restangular) ->
  () ->
    GithubRestangular.one('orgs', window.mgmt.organization).all('repos').getList().then((projects) ->
      _.map(projects, (p) ->
        name: p.name,
        type: if p.private then 'private' else 'public'
      )
    )
)
