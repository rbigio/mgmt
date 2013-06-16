services = angular.module('mgmt.services')

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