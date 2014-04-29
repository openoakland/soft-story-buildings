// Foundation JavaScript
// Documentation can be found at: http://foundation.zurb.com/docs
$(document).foundation();

var $details_el = $('#address_detail');

var substringMatcher = function(data) {
  return function(q, cb) {
    // regex used to determine if a string contains the substring `q`
    var regex = new RegExp(q, 'i');
    var matches = data
      .filter(function(addr) {return regex.test(addr)}) // filter out regex matches
      .slice(0,5); // return only first 5 results
    return cb(matches);
  };
};

$.get('/data/all.json', initTypeahead);

function initTypeahead(json) {
  $('#address_lookup').typeahead({}, {
    name: 'states',
    displayKey: function(row) {return row[0]},
    source: substringMatcher(json.rows)
  })
  .on('typeahead:selected', function($e, sugg) {
    $details_el.hide().fadeIn()
    $details_el.find('.addr').text(sugg[0])
    $details_el.find(".status span").hide()
    $details_el.find('.status span[data-status="' + sugg[1] + '"]').show()
    $details_el.find('.date').text(sugg[2] ? sugg[2] : 'Unknown')
  })
};
