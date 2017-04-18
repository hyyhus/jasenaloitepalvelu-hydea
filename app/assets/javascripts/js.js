$(document).on('turbolinks:load', function() {
  $(".open-button").on("click", function() {
    $(this).closest('.collapse-group').find('.collapse').collapse('show');
  });
});
