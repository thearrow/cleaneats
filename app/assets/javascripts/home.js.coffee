# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
    show_map = (position) ->
        latitude = position.coords.latitude;
        longitude = position.coords.longitude;
        alert("map shown: " + latitude + longitude)

    handle_error = ->
        $('#location-alert').css("display","block")

    $('#get-location-button').click ->
        if navigator.geolocation
            navigator.geolocation.getCurrentPosition(show_map, handle_error)
        else
            handle_error

