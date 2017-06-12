$ ->
  $(".new-apparat-permit-btn").click (e) ->
    apparat_id = $(".apparat-id").data("apparat-id")
    user_id = $("select#user").val()
    locked = $("input#locked").prop("checked")
    role = $("select#role").val()
    console.log(id)
    console.log(locked)
    console.log(role)
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
      success: (data, textStatus, jqXHR) ->
        console.log("Successful AJAX call: #{data}")
    e.preventDefault()

