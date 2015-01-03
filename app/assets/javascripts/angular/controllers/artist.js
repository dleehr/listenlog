/**
 * Created by dan on 1/3/15.
 */
'use strict';

angular.module('listenlog.controllers.artist', ['listenlog.resources.models'])
    .controller('ArtistController', ['Artist', ArtistController]);

function ArtistController(Artist) {
    this.Artist = Artist;
    this.reloadArtists();
}

ArtistController.prototype.reloadArtists = function() {
    this.artists = this.Artist.query();
};

ArtistController.prototype.create = function() {
    // artist.name
    var newArtist = {'name': this.artistName };
    var controllerThis = this;
    this.Artist.save({},newArtist, function() {
        controllerThis.error = null;
        controllerThis.artistName = '';
        controllerThis.reloadArtists();
    }, function(err) {
        controllerThis.error = err;
    });
};

ArtistController.prototype.save = function(artist) {
    var controllerThis = this;
    this.Artist.update({id:artist.id}, artist, function() {
        controllerThis.error = null;
    }, function(err) {
        controllerThis.error = err;
    });
};

ArtistController.prototype.delete = function(artist) {
    var controllerThis = this;
    this.Artist.delete({id:artist.id}, function() {
        controllerThis.error = null;
        controllerThis.reloadArtists();
    }, function(err) {
        controllerThis.error = err;
    });
};