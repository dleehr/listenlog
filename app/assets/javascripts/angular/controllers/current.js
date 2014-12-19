'use strict';

angular.module('listenlog.current',[])
.controller('CurrentController', CurrentController);

function CurrentController() {
    this.populateSamples();
}

CurrentController.prototype.populateSamples = function() {
    this.show = "Philadelphia, PA";
    this.recording = "Official Bootleg";
    this.artist = "Pearl Jam";
    this.date = "2000-09-01";
    this.song = "Sometimes";
};

