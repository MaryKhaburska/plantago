$(document).on("turbolinks:load", function() {
  $("#contacts-list").hide();
  $("#show-contacts-list").on("click", function(e){
    e.preventDefault();
    $("#contacts-list").slideToggle();
  });

  $(".append-contact-btn").on("click", function(e) {
    e.preventDefault();
    console.log("append-contact-btn");
  });
});
