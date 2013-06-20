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
	$scope.onMapLoad = ->
		console.log "map loaded"
		new google.maps.event.addListener $scope.map, "rightclick", dropMarker
		new google.maps.event.addListener $scope.map, "center_changed", logCenter

	dropMarker = (e) ->
		console.log "dropMarker", e
		new google.maps.Marker
			map: $scope.map
			position: e.latLng

	logCenter = ->
		console.log("map center is now", $scope.map.getCenter().toString())

MapCtrl.$inject = ['$scope']

angular.module('NetTalk.controllers').controller 'MapCtrl', MapCtrl
