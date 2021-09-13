toastr.options = Object.assign({}, toastr.options, {
  closeButton: true,
  progressBar: true
});

$(document).on('turbolinks:load', function () {
  $('#booking_total').prop('disabled', true); // second dropdown is disable while first dropdown is empty
  $('#booking_room_type').change(function () {
    let room_type = $(this).val();
    console.log(room_type)
    if (room_type == '') {
      $('#booking_total').prop('disabled', true);
    } else {
      $('#booking_total').prop('disabled', false);
    }
    $.ajax({
      url: '/rooms',
      method: 'GET',
      dataType: 'json',
      data: {room_type: room_type},
      error: function (xhr, status, error) {
        console.error('AJAX Error: ' + status + error);
      },
      success: function (response) {
        console.log(response);
        var rooms = response['rooms'];
        $('#booking_total').empty();

        $('#booking_total').append(`<option>${I18n.t("number")}</option>`);
        for (var i = 1; i <= rooms.length; i++) {
          $('#booking_total').append('<option value="' + i + '">' + i + '</option>');
        }
      }
    });
  });
})
