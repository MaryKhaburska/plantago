$(document).on "turbolinks:load", ->
  $(".new-apparat-permit-btn").click (e) ->
    apparat_id = $(".apparat-id").data("apparat-id")
    user_id = $("select#user").val()
    locked = $("input#locked").prop("checked")
    role = $("select#role").val()
    $.ajax "/users/#{user_id}/apparats_permits",
      type: "post"
      dataType: "script"
      data: {apparats_permit: {
        apparat_id: apparat_id
        user_id: user_id
        locked: locked,
        role: role
      }}
      error: (jqXHR, textStatus, errorrThrown) ->
        console.log("AJAX Error: #{textStatus}")
      # success: (data, textStatus, jqXHR) ->
      #   console.log("Successful AJAX call: #{data}")
    e.preventDefault()

  $(".remove-user-permit").on "click", (e) ->
    e.preventDefault()
    user_id = $(this).data("user-id")
    permit_id = $(this).data("permit-id")
    $.ajax "/users/#{user_id}/apparats_permits/#{permit_id}",
      type: "delete"
      dataType: "script"
      data: {
        id: permit_id
      }
      error: (jqXHR, textStatus, errorrThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Successful AJAX call: #{data}")
