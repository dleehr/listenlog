'use strict';

angular.module('listenlog.controllers.current', ['listenlog.resources.models'])
    .controller('CurrentController', ['Concert', 'Artist', 'Recording', 'ListenEvent', CurrentController]);

function CurrentController(Concert, Artist, Recording, ListenEvent) {
    // Capture resources
    this.Concert = Concert;
    this.Artist = Artist;
    this.Recording = Recording;
    this.ListenEvent = ListenEvent;
    this.loadConcerts();
    this.reload();
    this.isCollapsed = true;
}

CurrentController.prototype.loadConcerts = function () {
    this.concerts = this.Concert.query();
};

CurrentController.prototype.reload = function() {
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
    return this.lastListenEvent['is_start?'] == true;
};

CurrentController.prototype.updateButton = function() {
    if(this.listening()) {
        this.button_class = 'fa-stop';
        this.action_text = 'Stop';

    } else {
        this.button_class = 'fa-play';
        this.action_text = 'Start';
    }
};

CurrentController.prototype.button_text = function() {
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
    if(this.listening()) {
        this.recording.$finishListening({id:recordingId,note:this.note}, function() {
            controllerThis.reload();
        });
    } else {
        this.recording.$startListening({id:recordingId,note:this.note}, function() {
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