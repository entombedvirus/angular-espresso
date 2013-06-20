"use strict"

###
  Directives
###

app = angular.module("NetTalk.directives", ["ngResource"])

app.directive "appVersion", ["version", (version) ->
  (scope, elm, attrs) ->
    elm.text version
]

app.directive "googleMaps", ->
	DEFAULT_ZOOM_LEVEL = 15
	GoogleMaps = google.maps
	GoogleMaps.visualRefresh = true

	{
		restrict: 'E',
		#replace: true,
		compile: (elem, attrs, transclude) ->
			div = angular.element('<div id="mapView"/>')
			div.css({display: 'block'})
			#elem.replaceWith div
			elem.append div

			(scope, elem, attrs) ->
				lat = attrs.lat
				lng = attrs.lng
				map = scope[attrs.name]  = new GoogleMaps.Map(
					div[0]
				,
					center: new GoogleMaps.LatLng lat, lng
					zoom: DEFAULT_ZOOM_LEVEL
					mapTypeId: GoogleMaps.MapTypeId.ROADMAP
				)

				if attrs.onEvent?
					parts = attrs.onEvent.split ':', 2
					eventName = parts[0]
					action = parts[1]
					GoogleMaps.event.addListener map, eventName, (e) ->
						scope.e = e
						scope.$eval(action)
	}
