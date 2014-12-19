'use strict';

angular.module('listenlog.current', ['ngRoute'])
.config(['$routeProvider', function($routeProvider) {
        console.log('configuring /current');
        $routeProvider.when('/current', {
            templateUrl: '/templates/current.html',
            controller: 'CurrentCtrl'
        });
    }])
.controller('CurrentCtrl', [function() {
    console.log('current ctrl');
    }]);