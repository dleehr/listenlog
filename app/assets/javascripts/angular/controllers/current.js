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
        actions.push({ text: 'Pause', action: function() { controllerThis.pauseListening(); }});
        actions.push({ text: 'Finish', action: function() { controllerThis.finishListening(); }});
    } else {
        actions.push({ text: 'Resume', action: function() { controllerThis.resumeListening(); }});
    }
    return actions;
};

CurrentController.prototype.reload = function() {
    var controllerThis = this;
    this.lastListenEvent = controllerThis.ListenEvent.last({recording_id: controllerThis.recording.id}, function() {
        controllerThis.actions = controllerThis.nextActions();
        controllerThis.song = controllerThis.lastListenEvent.note;
        controllerThis.updateButton();
        controllerThis.concert = controllerThis.Concert.get({id:controllerThis.recording.concert_id}, function () {
            controllerThis.artist = controllerThis.Artist.get({id:controllerThis.concert.artist_id});
        });
    });
};

CurrentController.prototype.listening = function() {
    return this.recording['listening'] == true;
};

CurrentController.prototype.updateButton = function() {
    // TODO: rework to pause/resume/finish
    // array of buttons/actions
    if(this.listening()) {
        this.buttonClass = 'fa-stop';
        this.actionText = 'Stop';

    } else {
        this.buttonClass= 'fa-play';
        this.actionText = 'Start';
    }
};

CurrentController.prototype.buttonText = function() {
    if(this.isCollapsed) {
        return this.action_text;
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

CurrentController.prototype.updateDefaultNote = function() {
    if(this.listening()) {
        this.note = 'Paused';
    } else {
        this.note = 'Started';
    }
};

CurrentController.prototype.toggle = function() {
    // set the default action
    this.updateDefaultNote();
    this.isCollapsed = !this.isCollapsed;
};