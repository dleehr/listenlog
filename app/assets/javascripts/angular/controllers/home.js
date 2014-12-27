/**
 * Created by dan on 12/25/14.
 */
'use strict';

angular.module('listenlog.controllers.home', ['listenlog.resources.models'])
    .controller('HomeController', ['Recording', HomeController]);

function HomeController(Recording) {
    // set the active recordings
    this.activeRecordings = Recording.query({active:true});
}
