/**
 * Created by dan on 1/3/15.
 */
'use strict';

angular.module('listenlog.controllers.old', ['listenlog.resources.models'])
    .controller('OldController', ['Recording','Artist','Concert','ListenEvent', OldController]);

function OldController(Recording, Artist, Concert, ListenEvent) {
    this.Artist = Artist;
    this.Recording = Recording;
    this.Concert = Concert;
    this.ListenEvent = ListenEvent;
    this.reloadRecordings();
}

OldController.prototype.reloadRecordings = function() {
    var controllerThis = this;
    this.recordings = this.Recording.query({active:false}, function() {
        controllerThis.recordings.forEach(function(recording) {
            recording.lastListenEvent = controllerThis.ListenEvent.last({recording_id: recording.id}, function() {
                if(recording.concert_id) {
                    recording.concert = controllerThis.Concert.get({id: recording.concert_id}, function () {
                        recording.concert.artist = controllerThis.Artist.get({id: recording.concert.artist_id});
                    });
                }
            });
        });
    });
};
