$(document).on('turbolinks:load', function() {
  $(".open-button").on("click", function() {
    $(this).closest('.collapse-group').find('.collapse').collapse('show');
  });
});

$(document).on('turbolinks:load', function() {
  $(".glyphicon-option-horizontal").on("click", function() {
    var $panel = $(this).closest('.container');
    $('html,body').animate({
      scrollTop: $panel.offset().top
    }, 300);
  });
});
