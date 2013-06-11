module = angular.module('mgmt', ['mgmt.controllers', 'mgmt.services', 'mgmt.directives'])

module.config(['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  # $locationProvider.hashPrefix('!')
  # $locationProvider.html5Mode(true);

  $routeProvider.when('/',
    controller: 'DashboardCtrl',
    templateUrl:'/assets/dashboard/show.html'
  ).when('/projects',
    controller: 'ListProjectsCtrl',
    resolve:
      projects: (Projects) -> Projects()
    ,
    templateUrl:'/assets/projects/index.html'
  ).otherwise(
    redirectTo:'/'
  )
])
