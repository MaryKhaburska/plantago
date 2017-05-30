$(document).on "turbolinks:load", ->
  $("#show-contacts-list").click (e) ->
    e.preventDefault()
    $("#contacts-list").slideToggle()

  $(".remove-contact-from-list").click (e) ->
    e.preventDefault()
    itemId = $(this).data("id")
    $("#contacts-list-item-"+itemId).fadeOut()
