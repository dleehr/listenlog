'use strict';

angular.module('listenlog.controllers.new', ['listenlog.resources.models'])
    .controller('NewController', ['Concert', 'Artist', 'Recording', 'ListenEvent', '$scope', NewController]);

function NewController(Concert, Artist, Recording, ListenEvent, $scope) {
    // Initialize variables
    this.concert = {};
    this.recording = {};
    // Capture resources
    this.Concert = Concert;
    this.Artist = Artist;
    this.Recording = Recording;
    this.ListenEvent = ListenEvent;
    this.scope = $scope; // Need scope to emit event
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

NewController.prototype.enableButton = function() {
    return (this.concert.artist_id && this.concert.date && this.concert.location && this.recording.title);
};

NewController.prototype.success = function() {
    this.alertClass = 'alert-success';
    this.alertText = 'Successfully saved and started listening';
    this.scope.$emit('startedNewRecording');
};

NewController.prototype.failure = function(err) {
    this.alertClass = 'alert-danger';
    this.alertText = 'Unable to save ' + err;
};

NewController.prototype.start = function() {
    // concert object is ready to be posted
    var cThis= this;
    var startListening = function(recording) {
        cThis.recording.$startListening({id:cThis.recording.id,note:'Started'}, function() { cThis.success(); });
    };

    var saveRecording = function(concert) {
        cThis.recording.concert_id = concert.id;
        cThis.recording = cThis.Recording.save({}, cThis.recording, startListening, function(err) { cThis.failure(err); });
    };
    cThis.concert = cThis.Concert.save({},cThis.concert, saveRecording, function(err) { cThis.failure(err); });
};
