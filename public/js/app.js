$(function() {
  initializeDatePickers();

  $("#get_api_data").click(function(){
    var from_date = $('input[name=_from_date]').val();
    var to_date = $('input[name=_to_date]').val();
    var hash_tag_name = $('#hash_tag_name').val();
    loadInstagramApiData(from_date, to_date, hash_tag_name);
  });

  function loadInstagramApiData(from, to, hash_tag) {
    var dataApiTable = $("#data_api_table");
    var loading_bar = $('#loading_bar');

    dataApiTable.tablesorter();
    loading_bar.toggleClass('hide');

    $.ajax({
      url: "/load_data",
      data: {
        'from': from, 
        'to': to,
        'hash_tag': hash_tag
      },
      type: "GET",
      dataType : "html",
      success: function (html) {
        $("#data_api_table tbody").html("");
        $("#data_api_table tbody").append(html);
      }
    })
    .fail(function(xhr, status, errorThrown) {
      loading_bar.toggleClass('hide');
      alert("Sorry, there was a problem!");
    })
    .done(function(xhr, status) {
      loading_bar.toggleClass('hide');
      dataApiTable.trigger("update");
      return false;
    })
  };

  function initializeDatePickers() {
    var from_$input = $('#input_from').pickadate({
      formatSubmit: 'dd-mm-yyyy',
      hiddenSuffix: '_from_date'
    }),
        from_picker = from_$input.pickadate('picker')

    var to_$input = $('#input_to').pickadate({
      formatSubmit: 'dd-mm-yyyy',
      hiddenSuffix: '_to_date'
    }),
        to_picker = to_$input.pickadate('picker')

    // Check if there’s a “from” or “to” date to start with.
    if ( from_picker.get('value') ) {
      to_picker.set('min', from_picker.get('select'))
    }
    if ( to_picker.get('value') ) {
      from_picker.set('max', to_picker.get('select'))
    }

    // When something is selected, update the “from” and “to” limits.
    from_picker.on('set', function(event) {
      if ( event.select ) {
        to_picker.set('min', from_picker.get('select'))    
      }
      else if ( 'clear' in event ) {
        to_picker.set('min', false)
      }
    })
    to_picker.on('set', function(event) {
      if ( event.select ) {
        from_picker.set('max', to_picker.get('select'))
      }
      else if ( 'clear' in event ) {
        from_picker.set('max', false)
      }
    })
  };
})