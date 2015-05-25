Restaurant.reservations_controller ?=
  rowTemplate: _.template '''
    <% if (reservation_id) { %>
      <tr data-reservation-id="<%= reservation_id %>">
    <% } else { %>
      <tr>
    <% } %>
      <td><div class="form-group"><input name="start_time" class="form-control js-start-time datetimepicker" type="text"></input><div class="help-block"></div></div></td>
      <td><div class="form-group"><input name="end_time" class="js-end-time datetimepicker form-control" type="text"></input><div class="help-block"></div></div></td>
      <td><a href="#" class="btn btn-success btn-sm js-save-reservation-btn">Save</a></td>
    </tr>
  '''

  init: ->
    $(document).on 'ajax:success', '.js-delete-reservation-btn', (e) ->
      manageButton = $(e.target).closest('.restaurant-table').find('.js-manage-btn')
      manageButton.popover('destroy')
      $.gritter.add({ title: 'Reservation management', text: 'Reservation was successfully deleted', image: '/assets/success.png'})

    $(document).on 'click', '.js-save-reservation-btn', (e) =>
      e.preventDefault()
      tr = $(e.target).closest('tr')

      tableId = tr.closest('.js-reservation-table').data('table-id')
      startTime = tr.find('.js-start-time').val()
      endTime = tr.find('.js-end-time').val()
      reservationId = tr.data('reservation-id')

      if reservationId?
        url = Routes.reservation_path(reservationId)
        type = 'PATCH'
        message = 'Reservation was successfully updated'
      else
        url = Routes.reservations_path()
        type = 'POST'
        message = 'Reservation was successfully created'

      $.ajax
        type: type
        url: url
        data:
          reservation:
            start_time: startTime
            end_time: endTime
            table_id: tableId
        success: (data) =>
          manageButton = $(e.target).closest('.restaurant-table').find('.js-manage-btn')
          manageButton.popover('destroy')
          $.gritter.add({ title: 'Reservation management', text: message, image: '/assets/success.png'})
        error: (data) =>
          @renderErrors(tr, $.parseJSON(data.responseText))

    $(document).on 'click', '.js-edit-reservation-btn', (e) =>
      e.preventDefault()
      btn = $(e.currentTarget)
      reservationId = btn.data('reservation-id')
      startTime = btn.data('start-time')
      endTime = btn.data('end-time')

      btn.closest('tr').replaceWith(@rowTemplate(reservation_id: reservationId))

      $('.js-start-time').datetimepicker
        format: 'DD/MM/YYYY HH:mm'
        defaultDate: startTime
      $('.js-end-time').datetimepicker
        format: 'DD/MM/YYYY HH:mm'
        defaultDate: endTime

    $(document).on 'click', '.js-new-reservation-btn', (e) =>
      e.preventDefault()
      lastRow = $(e.target).closest('.popover-content').find('.js-reservation-table tr:last')

      if lastRow.hasClass('js-empty-row')
        lastRow.closest('table').find('thead').show()
        lastRow.replaceWith(@rowTemplate(reservation_id: ''))
      else
        lastRow.after(@rowTemplate(reservation_id: ''))

      $('.js-start-time, .js-end-time').datetimepicker
        format: 'DD/MM/YYYY HH:mm'

    $(document).on 'click', '.js-manage-btn', (e) =>
      btn = $(e.target)
      if btn.data('bs.popover')?
        btn.popover('destroy')
      else
        @initPopover(btn)

  initPopover: (btn) ->
    $.ajax
      type: 'GET'
      url: btn.data('url')
      success: (html) ->
        btn.popover
          html: true
          content: html
        btn.popover('show')

  renderErrors: (tr, errors) ->
    for field, messages of errors
      input = tr.find('input[name="' + field + '"]')
      input.closest('.form-group').addClass('has-error').find('.help-block').html(messages[0])
