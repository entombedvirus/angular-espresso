"use strict"

###
  Controllers
###

SocketCtrl = ($scope, Socket) ->

  Socket.on "pong", (data) ->
    $scope.response = data.data

  $scope.ping = ->
    Socket.emit("ping", {})

SocketCtrl.$inject = ["$scope", "Socket"]

angular.module('NetTalk.controllers').controller 'SocketCtrl', SocketCtrl

MapCtrl = ($scope) ->
	$scope.dropMarker = (e) ->
		console.log "scope.map", $scope.map
		console.log "dropMarker", e
		new google.maps.Marker
			map: $scope.map
			position: e.latLng

	$scope.logCenter = ->
		console.log("map center is now", $scope.map.getCenter().toString())

MapCtrl.$inject = ['$scope']

angular.module('NetTalk.controllers').controller 'MapCtrl', MapCtrl
