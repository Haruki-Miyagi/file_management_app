$(document).on('turbolinks:load', function() {
  $('.js-l-side-nav-toggle').on('click', function(event){
    event.preventDefault();
    var $this = $(this);

    if ($('body').hasClass('offcanvas')) {
      $this.removeClass('active');
      $('body').removeClass('offcanvas');	
    } else {
      $this.addClass('active');
      $('body').addClass('offcanvas');	
    }
  });
});
