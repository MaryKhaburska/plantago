$(document).on "turbolinks:load", ->
  $("#show-contacts-list").click (e) ->
    e.preventDefault()
    $("#contacts-list").slideToggle()

