'use strict';

angular.module('listenlog.controllers.current', ['listenlog.resources.concert'])
    .controller('CurrentController', ['Concert', CurrentController]);

function CurrentController(Concert) {
    this.populateSamples();
    this.loadConcerts(Concert);
}

CurrentController.prototype.loadConcerts = function (Concert) {
    this.populateSamples();
    this.concerts = Concert.query();
};

CurrentController.prototype.populateSamples = function() {
    this.show = "Philadelphia, PA";
    this.recording = "Official Bootleg";
    this.artist = "Pearl Jam";
    this.date = "2000-09-01";
    this.song = "Sometimes";
};

