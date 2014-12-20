'use strict';

angular.module('listenlog.controllers.current', ['listenlog.resources.models'])
    .controller('CurrentController', ['Concert', 'Artist', 'Recording', 'ListenEvent', CurrentController]);

function CurrentController(Concert, Artist, Recording, ListenEvent) {
    // Capture resources
    this.Concert = Concert;
    this.Artist = Artist;
    this.Recording = Recording;
    this.ListenEvent = ListenEvent;
    this.loadConcerts(Concert);
    this.reload();
}

CurrentController.prototype.reload = function() {
    var controllerThis = this;
    this.lastListenEvent = controllerThis.ListenEvent.last(function() {
        controllerThis.song = controllerThis.lastListenEvent.note;
        controllerThis.button_class = 'fa-play';
        controllerThis.button_text = 'Start';
        controllerThis.recording = controllerThis.Recording.get({id:controllerThis.lastListenEvent.recording_id}, function() {
            controllerThis.concert = controllerThis.Concert.get({id:controllerThis.recording.concert_id}, function () {
                controllerThis.artist = controllerThis.Artist.get({id:controllerThis.concert.artist_id});
            });
        });
    });
};

CurrentController.prototype.loadConcerts = function (Concert) {
    this.concerts = Concert.query();
};

