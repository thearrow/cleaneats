# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  show_error_alert = ->
    $('#location-alert').css('display', 'block')

  hide_titleblock = ->
    $('#titleblock').css('display', 'none')

  show_map = (position) ->
    hide_titleblock()
    mapOptions =
      center: new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
      zoom: 13
      streetViewControl: false
      panControl: false
      zoomControl: true
    map = new google.maps.Map(document.getElementById("map"),mapOptions)
    marker = new google.maps.Marker
      map: map
      animation: google.maps.Animation.DROP
      position: new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
      icon: 'http://maps.google.com/mapfiles/marker_grey.png'

  $('#get-location-button').click ->
    if navigator.geolocation
        navigator.geolocation.getCurrentPosition(show_map, show_error_alert)
    else
      show_error_alert

