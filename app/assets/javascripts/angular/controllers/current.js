'use strict';

angular.module('listenlog.controllers.current', ['listenlog.resources.models'])
    .controller('CurrentController', ['Concert', 'Artist', 'Recording', 'ListenEvent', CurrentController]);

function CurrentController(Concert, Artist, Recording, ListenEvent) {
    // Capture resources
    this.Concert = Concert;
    this.Artist = Artist;
    this.Recording = Recording;
    this.ListenEvent = ListenEvent;
    this.isCollapsed = true;
    this.eventTypes = {
        START: 1,
        PAUSE: 2,
        RESUME: 3,
        FINISH: 4
        };
}

CurrentController.prototype.init = function(recording) {
    this.recording = recording;
    // Now populate things
    this.reload();
};

CurrentController.prototype.loadConcerts = function () {
    this.concerts = this.Concert.query();
};

CurrentController.prototype.nextActions = function() {
    var controllerThis = this;
    var actions = [];
    if(    (this.lastListenEvent.event_type == this.eventTypes.START)
        || (this.lastListenEvent.event_type == this.eventTypes.RESUME)) {
        // currentlyPlaying
        actions.push({ text: 'Pause', showNote: true, defaultNote: 'paused', buttonClass: 'fa-pause', action: function() { controllerThis.pauseListening(); }});
        actions.push({ text: 'Finish', showNote: false, defaultNote: 'finished', buttonClass: 'fa-flag-checkered', action: function() { controllerThis.finishListening(); }});
    } else {
        actions.push({ text: 'Resume', showNote: true, defaultNote: 'resumed', buttonClass: 'fa-play', action: function() { controllerThis.resumeListening(); }});
    }
    return actions;
};

CurrentController.prototype.reload = function() {
    var controllerThis = this;
    this.lastListenEvent = controllerThis.ListenEvent.last({recording_id: controllerThis.recording.id}, function() {
        controllerThis.actions = controllerThis.nextActions();
        controllerThis.song = controllerThis.lastListenEvent.note;
        controllerThis.concert = controllerThis.Concert.get({id:controllerThis.recording.concert_id}, function () {
            controllerThis.artist = controllerThis.Artist.get({id:controllerThis.concert.artist_id});
        });
    });
};


CurrentController.prototype.buttonText = function(text) {
    if(this.isCollapsed) {
        return text;
    } else {
        return 'Cancel';
    }
};

// Can't use the instance method because the API returns a ListenEvent,
// but the ng-resource REST client will overwrite this.recording with the retrurned ListenEvent

CurrentController.prototype.pauseListening = function() {
    var controllerThis = this;
    this.Recording.pauseListening({id: this.recording.id}, {note: this.note}, function() {
        controllerThis.reload();
    });
};

CurrentController.prototype.resumeListening = function() {
    var controllerThis = this;
    this.Recording.resumeListening({id: this.recording.id}, {note: this.note}, function() {
        controllerThis.reload();
    });
};

CurrentController.prototype.finishListening = function() {
    var controllerThis = this;
    this.Recording.finishListening({id: this.recording.id}, {note: this.note}, function() {
        controllerThis.reload();
    });
};

CurrentController.prototype.submit = function() {
    this.isCollapsed = true;
    // Determine if pause, resume, or finish
    var action = this.selectedAction.action;
    action();
};

CurrentController.prototype.toggle = function(action) {
    this.isCollapsed = !this.isCollapsed;
    if(this.isCollapsed) {
        this.selectedAction = null;
    } else {
        this.selectedAction = action;
        this.note = angular.copy(this.selectedAction.defaultNote);
    }
};

CurrentController.prototype.textForLastEvent = function() {
    var eventType = this.lastListenEvent.event_type;
    var text = "unknown";
    switch(eventType) {
        case this.eventTypes.START:
            text = "Listening";
            break;
        case this.eventTypes.RESUME:
            text = "Listening";
            break;
        case this.eventTypes.PAUSE:
            text = "Paused";
            break;
        case this.eventTypes.FINISH:
            text = "Finished";
            break;
    }
    return text;
};