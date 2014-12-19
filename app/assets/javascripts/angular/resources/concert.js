'use strict';

angular.module('listenlog.resources.concert',['ngResource'])
    .factory('Concert', ['$resource', function($resource) {
      return $resource('/concerts/:id.json');
    }]);
