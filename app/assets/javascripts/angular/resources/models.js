'use strict';

angular.module('listenlog.resources.models',['ngResource'])
    .factory('Concert', ['$resource', function($resource) { return $resource('/concerts/:id.json'); }])
    .factory('Artist', ['$resource', function($resource) { return $resource('/artists/:id.json'); }])
    .factory('Recording', ['$resource', function($resource) { return $resource('/recordings/:id.json'); }])
    .factory('ListenEvent', ['$resource', function($resource) {
        return $resource('/listen_events/:id.json', {},
                { last: { method: 'GET', params:{ id : 'last' } }
            });
    }])
;
