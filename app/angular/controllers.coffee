"use strict"

###
  Controllers
###

AppCtrl = ($scope) ->
  $scope.name = "Espresso"

AppCtrl.$inject = ["$scope"]

angular.module('NetTalk.controllers').
	controller 'AppCtrl', AppCtrl

UsersCtrl = ($scope, User) ->
  $scope.loadUsers = ->
    $scope.users = {}
    User.list {}
    , (data) ->
      $scope.users = data.message

UsersCtrl.$inject = ["$scope", "User"]

angular.module('NetTalk.controllers').
	controller 'UsersCtrl', UsersCtrl

UserDetailCtrl = ($scope, $routeParams, User) ->
  $scope.user =
    User.get {userId: $routeParams.userId}
    , (data) ->
      $scope.user = data.user

UserDetailCtrl.$inject = ["$scope", "$routeParams", "User"]

angular.module('NetTalk.controllers').
	controller 'UserDetailCtrl', UserDetailCtrl

SocketCtrl = ($scope, Socket) ->

  Socket.on "pong", (data) ->
    $scope.response = data.data

  $scope.ping = ->
    Socket.emit("ping", {})

SocketCtrl.$inject = ["$scope", "Socket"]

angular.module('NetTalk.controllers').
	controller 'SocketCtrl', SocketCtrl

MapCtrl = ($scope) ->
	console.log "scope.map", $scope.map
	$scope.dropMarker = (e) ->
		console.log "dropMarker", e
		new google.maps.Marker
			map: $scope.map
			position: e.latLng

	$scope.logCenter = ->
		console.log("map center is now", $scope.map.getCenter().toString())

angular.module('NetTalk.controllers').controller 'MapCtrl', MapCtrl
