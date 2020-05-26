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
            // $.rails.enableFormElements($($.rails.formSubmitSelector));
            $.rails.enableFormElements($('#new_tag'));
          },
        });
      });
    },
  });

  $('.select-input-tags').selectize({
    sortField: 'text',
  });

  $("input[type=checkbox][id^='question_option']").change(function () {
    $("input[type=checkbox][id^='question_option']:checked")
      .not(this)
      .prop('checked', false);
  });
  var get_url = $('#start-trivia-btn').attr('href');
  $('#select-tag').change(function (e) {
    $('#all-tags-check').prop('disabled', true);
    var tag_id = $(this).val();
    $('#start-trivia-btn').attr('href', get_url + tag_id);
    $('#start-trivia-btn').show();
  });

  $("input[type=checkbox][class='chk-btn']").change(function () {
    if (this.checked) {
      $('#select-tag')[0].selectize.disable();
      $('#start-trivia-btn').attr('href', get_url + 'all-tags');
      $('#start-trivia-btn').show();
    } else {
      $('#start-trivia-btn').attr('href', get_url);
      $('#select-tag')[0].selectize.enable();
      $('#start-trivia-btn').hide();
    }
  });

  var questionAnswered = $('.question-title').attr('data-answered');
  if (questionAnswered == 'true') {
    $('.next-button').show();
  } else {
    $('.next-button').hide();
  }

  $("table[role='datatable']").each(function () {
    $(this).DataTable();
  });
});
$(window).on('unload', function (e) {
  $.rails.enableFormElements($($.rails.formSubmitSelector));
});
