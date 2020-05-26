require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');
window.jQuery = window.$ = require('jquery');
// require('jquery-ujs');
require('selectize');
import 'bootstrap';
require('datatables.net');
require('datatables.net-bs4');
require('datatables.net-bs4/css/dataTables.bootstrap4.min.css');
import '../stylesheets/application.scss';
var trivia_start = false;
document.addEventListener('turbolinks:load', () => {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();

  var selectizeCallback = null;

  $('.tag-modal').on('hide.bs.modal', function (e) {
    if (selectizeCallback != null) {
      selectizeCallback();
      selectizeCallback = null;
    }
  });
  $('.selectize').selectize({
    create: function (input, callback) {
      selectizeCallback = callback;

      $('.tag-modal').modal();
      $('#new_tag').trigger('reset');
      $('#tag_name').val(input);
      $('#new_tag').on('submit', function (e) {
        e.preventDefault();
        $.ajax({
          method: 'POST',
          url: $(this).attr('action'),
          data: $(this).serialize(),
          success: function (response) {
            selectizeCallback({
              value: response.id,
              text: response.name,
            });
            selectizeCallback = null;
            $('.tag-modal').modal('toggle');
            // $.rails.enableFormElements($('#new_tag'));
          },
        });
      });
    },
  });

  $('input[type=checkbox]').change(function () {
    // When any radio button on the page is selected,
    // then deselect all other radio buttons.
    $('input[type=checkbox]:checked').not(this).prop('checked', false);
  });
  $('#select-tag').change(function (e) {
    console.log($(this).val());
    var tag_id = $(this).val();
    var get_url = $('#start-trivia-btn').attr('href');
    $('#start-trivia-btn').attr('href', get_url + tag_id);
    $('#start-trivia-btn').show();
  });

  var questionAnswered = $('.question-title').attr('data-answered');
  if (questionAnswered == 'true') {
    $('.next-button').show();
  } else {
    $('.next-button').hide();
  }

  $("table[role='datatable']").each(function () {
    $(this).DataTable({
      // processing: true,
      // serverSide: true,
      // ajax: $(this).data('url'),
    });
  });
});
