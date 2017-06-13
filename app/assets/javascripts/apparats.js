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

