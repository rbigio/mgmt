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
  ).when('/projects/:name',
    controller: 'ViewProjectCtrl',
    resolve:
      project: (Restangular, $route) ->
        Restangular.one('projects', $route.current.params.name).get(
          organization: window.mgmt.organization
        )
    ,
    templateUrl:'/assets/projects/show.html'
  ).otherwise(
    redirectTo:'/'
  )
])