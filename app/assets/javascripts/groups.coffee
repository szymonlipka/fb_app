$(document).ready ->
  if $('.btn-add-friend').length is 0
    $('.adding-users').hide()
    $(".column-right").prepend( "<p>Add more friends to invite them to this group</p>" );
  else
    $('.btn-add-friend').click ->
      if $('#username').val() == ''
        $('#username').val($(this).text())
        $('#ids').val($(this).attr('id'))
        $(this).hide()
      else
        $('#username').val($('#username').val() + ', ' + $(this).text())
        $('#ids').val($('#ids').val() + ' ' + $(this).attr('id'))
        $(this).hide()