/**
 * Created by dan on 1/3/15.
 */
'use strict';

angular.module('listenlog.controllers.artist', ['listenlog.resources.models'])
    .controller('ArtistController', ['Artist', ArtistController]);

function ArtistController(Artist) {
    this.Artist = Artist;
    this.alerts = new Array();
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
        controllerThis.alerts.push({type:'success', msg: 'Created ' + newArtist.name});
        controllerThis.artistName = '';
        controllerThis.reloadArtists();
    }, function(err) {
        controllerThis.alerts.push({type:'danger', msg: err});
    });
};

ArtistController.prototype.save = function(artist) {
    var controllerThis = this;
    this.Artist.update({id:artist.id}, artist, function() {
        controllerThis.alerts.push({type:'success', msg: 'Updated ' + artist.name});
    }, function(err) {
        controllerThis.alerts.push({type:'danger', msg: err});
    });
};

ArtistController.prototype.delete = function(artist) {
    var controllerThis = this;
    this.Artist.delete({id:artist.id}, function() {
        controllerThis.error = null;
        controllerThis.alerts.push({type:'success', msg: 'Deleted ' + artist.name});
        controllerThis.reloadArtists();
    }, function(err) {
        controllerThis.alerts.push({type:'danger', msg: err});
    });
};

ArtistController.prototype.closeAlert = function(index) {
    this.alerts.splice(index, 1);
};