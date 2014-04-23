// Foundation JavaScript
// Documentation can be found at: http://foundation.zurb.com/docs
$(document).foundation();

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
  $('#address_lookup .typeahead').typeahead({}, {
    name: 'states',
    displayKey: function(row) {return row[0]},
    source: substringMatcher(json.rows)
  });
};
