// Foundation JavaScript
// Documentation can be found at: http://foundation.zurb.com/docs
$(document).foundation();

var $details_el = $('#address_detail');

function renderDetails(data) {
  $details_el.hide().fadeIn()
  $details_el.find('.addr').text(data.addr)
  $details_el.find('.notified').text(data.notified)
  $details_el.find('.status').text(data.status)
}

function substringMatcher(data) {
  return function(q, cb) {
    // regex used to determine if a string contains the substring `q`
    var regex = new RegExp(q, 'i');
    var matches = data
      .filter(function(addr) {return regex.test(addr)}) // filter out regex matches
      .slice(0,5); // return only first 5 results
    return cb(matches);
  };
}

$.get('data/all.json', initTypeahead);

function initTypeahead(json) {
  $('#address_lookup').typeahead({}, {
    name: 'states',
    displayKey: function(row) {return row[0]},
    source: substringMatcher(json.rows)
  })
  .on('typeahead:selected', function($e, sugg) {
    renderDetails({addr: sugg[0], notified: sugg[1], status: sugg[2]})
  })
}

function initMap() { 
  var lat = 37.8043637
  var lng = -122.2711137
  var map = new google.maps.Map(document.getElementById("gmap_canvas"), {
    zoom: 12,
    center: new google.maps.LatLng(lat, lng),
    mapTypeId: google.maps.MapTypeId.ROADMAP
  })
}

function initMarkers(markers) {
}

initMap()
