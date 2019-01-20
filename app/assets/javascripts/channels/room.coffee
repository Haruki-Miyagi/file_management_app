document.addEventListener 'turbolinks:load', ->
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: $('#messages').data('room_id') },
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      $('#messages').append data['message']
      height = $('.scroll-bar')[0].scrollHeight
      $('.scroll-bar').scrollTop(height)

    speak: (message) ->
      @perform 'speak', message: message
    
  $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    if (event.keyCode is 13 && event.ctrlKey) # return = send
      App.room.speak event.target.value
      event.target.value = ''
      event.preventDefault()

  $('#send-btn').on 'click',  ->
    App.room.speak $('#message-box').val()
    $('#message-box').val('')
