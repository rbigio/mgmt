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
    RestangularConfigurer.setBaseUrl('https://api.github.com/orgs/' + window.mgmt.organization)
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
    GithubRestangular.all('repos').getList(
    ).then((projects) ->
      _.map(projects, (p) ->
        name: p.name,
        type: if p.private then 'private' else 'public'
      )
    )
)
