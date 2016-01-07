$(document).ready ->
  $("#post_content").keypress (e) ->
    if e.which is 13
      event.preventDefault();    
      $(this).closest('form').submit()
      $('input[type="text"],textarea').val('');