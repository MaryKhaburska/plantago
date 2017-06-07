$(document).on("turbolinks:load", function() {
  $("#contacts-list").hide();
  $("#show-contacts-list").on("click", function(e){
    e.preventDefault();
    $("#contacts-list").slideToggle();
  });

  // Append contact action. Add contact for current apparat.
  // Apeend this contact to cantacts-list.
  // Remove from selection input.
  // $(".append-contact-btn").on("click", function(e){
  $(document).on("click", ".append-contact-btn", function(e){
    e.preventDefault();
    var contactId = $(".append-contact-selection").val()
    var apparatId = $(".apparat-id").data("apparat-id");
    $.ajax({
      url: "add_contact",
      type: "patch",
      dataType: "script",
      data: {
        contact_id: contactId
      },
      success: function(){
        $("select#contact_id [value="+ contactId +"]").remove();
      }
    });
  });
});
