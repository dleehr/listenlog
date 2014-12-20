'use strict';

angular.module('listenlog.controllers.new', ['listenlog.resources.models'])
    .controller('NewController', ['Concert', 'Artist', 'Recording', 'ListenEvent', NewController]);

function NewController(Concert, Artist, Recording, ListenEvent) {
    // Capture resources
    this.Concert = Concert;
    this.Artist = Artist;
    this.Recording = Recording;
    this.ListenEvent = ListenEvent;
    this.loadArtists();
}

NewController.prototype.loadConcerts = function () {
    this.concerts = this.Concert.query();
};

NewController.prototype.loadArtists = function() {
    this.artists = this.Artist.query();
};

NewController.prototype.openDatePicker = function($event) {
    $event.preventDefault();
    $event.stopPropagation();
    this.datePickerOpened = true;
};
