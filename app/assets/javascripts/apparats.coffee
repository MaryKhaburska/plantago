$(document).on "turbolinks:load", ->
  $("#show-contacts-list").click (e) ->
    e.preventDefault()
    $("#contacts-list").slideToggle()

  $(".remove-contact-from-list").click (e) ->
    e.preventDefault()