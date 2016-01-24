$(document).ready ->
  unless $('.btn-add-friend').size() is 0
    $('.adding-users').show()
    $('p').hide()
    $('.btn-add-friend').click ->
      if $('#username').val() == ''
        $('#username').val($(this).text())
        $('#ids').val($(this).attr('id'))
        $(this).hide()
      else
        $('#username').val($('#username').val() + ', ' + $(this).text())
        $('#ids').val($('#ids').val() + ',' + $(this).attr('id'))
        $(this).hide()