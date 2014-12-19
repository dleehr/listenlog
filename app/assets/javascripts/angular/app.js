'use strict';

angular.module('listenlog', [
    'ngResource',
    'ngRoute',
    'listenlog.current'
]).config(['$routeProvider', function($routeProvider) {
    console.log('configuring routeprovider');
    $routeProvider.otherwise({redirectTo: '/current'});
}]);