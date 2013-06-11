services = angular.module('mgmt.services', ['restangular']);

services.config((RestangularProvider) ->
  RestangularProvider.setBaseUrl("https://api.github.com/orgs/" + window.mgmt.organization)
)

services.factory('Projects', ['Restangular', (Restangular) ->
  () ->
    Restangular.all('repos').getList(
      'type': 'all',
      'per_page': 1000,
      'sort': 'updated',
      'direction': 'desc'
    ,
      'Accept': 'application/vnd.github.raw',
      'Content-Type': 'application/json',
      'Authorization': 'token ' + window.mgmt.token
    ).then((projects) ->
      _.map(projects, (p) ->
        name: p.name,
        type: if p.private then 'private' else 'public'
      )
    )
])
