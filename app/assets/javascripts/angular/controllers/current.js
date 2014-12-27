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
}

CurrentController.prototype.init = function(recording) {
    this.recording = recording;
    console.log("initialized with " + recording.title);
    // Now populate things
};

CurrentController.prototype.loadConcerts = function () {
    this.concerts = this.Concert.query();
};

CurrentController.prototype.reload = function() {
    // TODO: rework this to start with a recording
    var controllerThis = this;
    this.lastListenEvent = controllerThis.ListenEvent.last(function() {
        controllerThis.song = controllerThis.lastListenEvent.note;
        controllerThis.updateButton();
        controllerThis.recording = controllerThis.Recording.get({id:controllerThis.lastListenEvent.recording_id}, function() {
            controllerThis.concert = controllerThis.Concert.get({id:controllerThis.recording.concert_id}, function () {
                controllerThis.artist = controllerThis.Artist.get({id:controllerThis.concert.artist_id});
            });
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

CurrentController.prototype.submit = function() {
    this.isCollapsed = true;
    var recordingId = this.recording.id;
    var controllerThis = this;
    // Determine if pause, resume, or finish
    if(this.listening()) {
        this.recording.$pauseListening({id:recordingId,note:this.note}, function() {
            controllerThis.reload();
        });
    } else {
        this.recording.$resumeListening({id:recordingId,note:this.note}, function() {
            controllerThis.reload();
        });
    }};

CurrentController.prototype.updateDefaultNote = function() {
    if(this.listening()) {
        this.note = 'Finished';
    } else {
        this.note = 'Started';
    }
};

CurrentController.prototype.toggle = function() {
    // set the default action
    this.updateDefaultNote();
    this.isCollapsed = !this.isCollapsed;
};