services = angular.module('mgmt.services', ['restangular'])

# TODO: use this only for GithubRestangular
services.config(['$httpProvider', ($httpProvider) ->
  $httpProvider.defaults.headers.get =
    'Accept': 'application/vnd.github.raw',
    'Content-Type': 'application/json',
    'Authorization': 'token ' + window.mgmt.token
])