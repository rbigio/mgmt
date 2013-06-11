module = angular.module('mgmt.controllers')

module.controller('ListProjectsCtrl', ['$scope', 'projects', ($scope, projects) ->
  $scope.projects = projects
  $scope.private = _.filter(projects, (p) -> p.type == 'private')
  $scope.public = _.filter(projects, (p) -> p.type == 'public')
])
