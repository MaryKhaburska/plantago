$(document).on "turbolinks:load", ->
  console.log("turbolinks load")
  $("form#append-user-form").on "submit", (event) ->
    console.log($(this).serializeArray())
    event.preventDefault()
