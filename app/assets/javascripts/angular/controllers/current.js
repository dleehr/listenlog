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
        this.button_text = 'Stop';

    } else {
        this.button_class = 'fa-play';
        this.button_text = 'Start';
    }
};

CurrentController.prototype.buttonClicked = function() {
    var recordingId = this.recording.id;
    var controllerThis = this;
    if(this.listening()) {
        this.recording.$finishListening({id:recordingId}, function() {
            controllerThis.reload();
        });
    } else {
        this.recording.$startListening({id:recordingId}, function() {
            controllerThis.reload();
        });
    }
};