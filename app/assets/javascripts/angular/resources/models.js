'use strict';

angular.module('listenlog.resources.models',['ngResource'])
    .factory('Concert', ['$resource', function($resource) { return $resource('/concerts/:id.json'); }])
    .factory('Artist', ['$resource', function($resource) {
        return $resource('/artists/:id.json', {},
            { update: { method: 'PUT' }}
        );
    }])
    .factory('Recording', ['$resource', function($resource) {
        return $resource('/recordings/:id/:action.json', {},
            {
                startListening: { method: 'POST', params: { action: 'start_listening' }},
                pauseListening: { method: 'POST', params: { action: 'pause_listening' }},
                resumeListening: { method: 'POST', params: { action: 'resume_listening' }},
                finishListening: { method: 'POST', params: { action: 'finish_listening' }}
            }
        );
    }])
    .factory('ListenEvent', ['$resource', function($resource) {
        return $resource('/recordings/:recording_id/listen_events/:id.json', {},
            {
                last: { method: 'GET', params:{ id : 'last' } }
            }
        );
    }])
;
