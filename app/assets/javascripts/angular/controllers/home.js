/**
 * Created by dan on 12/25/14.
 */
'use strict';

angular.module('listenlog.controllers.home', ['listenlog.resources.models'])
    .controller('HomeController', ['Recording', '$scope', HomeController]);

function HomeController(Recording, $scope) {
    // set the active recordings
    this.Recording = Recording;
    this.reloadActive();
    var controllerThis = this;
    // NewController should send a switchToActive notification, causing us to reload activeRecordings and set the active tab
    $scope.$on('startedNewRecording', function(event) {
        controllerThis.reloadActive();
        controllerThis.switchToCurrent();
    });
}

HomeController.prototype.reloadActive = function() {
    this.activeRecordings = this.Recording.query({active:true});
};

HomeController.prototype.switchToCurrent = function() {
    this.currentActive = true;
};