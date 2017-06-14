$(document).on("turbolinks:load", function() {
  // hide-show contacts list
  $("#contacts-list").hide();
  $("#show-contacts-list").on("click", function(e){
    e.preventDefault();
    $("#contacts-list").slideToggle("fast");
  });

  // hide-show users-list
  $(".users-list").hide();
  $(".show-users-list").on("click", function(e){
    e.preventDefault();
    $(".users-list").slideToggle("fast");
  });

  // hide empty select when page is loaded
  if ($(".append-user-form select#user option").size() == 0) {
    $(".append-user-form").hide();
  } else {
    $(".append-user-form").show();
  }
});


// Append contact action. Add contact for current apparat.
// Apeend this contact to cantacts-list.
// Remove from selection input.
$(document).on("click", ".append-contact-btn", function(e){
  e.preventDefault();
  var contactId = $(".append-contact-selection").val();
  var apparatId = $(".apparat-id").data("apparat-id");
  $.ajax({
    url: "/apparats/"+apparatId+"/add_contact",
    type: "patch",
    dataType: "script",
    data: {
      contact_id: contactId
    },
    success: function(){
      var selectSize = 0;
      $("select#contact_id [value="+ contactId +"]").remove();
      selectSize = $("select#contact_id option").size();
      if (selectSize == 0) {
        $(".append-contact-form").empty();
      }
    }
  });
});

// Create new user apparat permit
$(document).on("click", ".new-apparat-permit-btn", function(e){
  e.preventDefault();
  var apparatId = $(".apparat-id").data("apparat-id");
  var userId = $(".append-user-form select#user").val();
  var isLocked = $(".append-user-form input#locked").prop("checked");
  var role = $(".append-user-form select#role").val();
  $.ajax({
    url: "/users/"+userId+"/apparats_permits",
    type: "POST",
    dataType: "script",
    data: {apparats_permit: {
      apparat_id: apparatId,
      role: role,
      locked: isLocked
    }}
  });
});

// Update permit parameter "locked"
$(document).on("click", ".apparat-permits-users-list input#locked", function(e){
  var userId   = $(this).data("user-id");
  var permitId = $(this).data("permit-id");
  var value    = $(this).prop("checked");
  console.log("user_id: " + userId + " | permit_id: " + permitId + " | value: " + value);
  $.ajax({
    url: "/users/" + userId + "/apparats_permits/" + permitId,
    type: "PUT",
    dataType: "script",
    data: {apparats_permit: {
      locked: value
    }},
  });
});

// Update permit parameter "role"
$(document).on("change", ".apparat-permits-users-list select#role", function(e){
  var userId   = $(this).data("user-id");
  var permitId = $(this).data("permit-id");
  var value    = $(this).val();
  console.log("user_id: " + userId + " | permit_id: " + permitId + " | value: " + value);
  $.ajax({
    url: "/users/" + userId + "/apparats_permits/" + permitId,
    type: "PUT",
    dataType: "script",
    data: {apparats_permit: {
      role: value
    }},
    error: function(jqXHR, textStatus, errorThrown){
      console.log(jqXHR);
      console.log(textStatus);
      console.log(errorThrown);
    },
    success: function(data, textStatus, jqXHR){
      // console.log(data);
      console.log(textStatus);
      // console.log(jqXHR);
    }
  });
});

