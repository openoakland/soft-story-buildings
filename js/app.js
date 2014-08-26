// Foundation JavaScript
// Documentation can be found at: http://foundation.zurb.com/docs
$(document).foundation();

var $details_el = $('#address_detail');

function renderDetails(row) {
  var addr = row[0]
  var notified = row[1]
  var status = row[2]
  $details_el.hide().fadeIn()
  $details_el.find('.addr').text(addr)
  $details_el.find('.notified').text(notified)
  $details_el.find('.status').text(status)
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
  var googleMap = initMap()
  $('#address_lookup').typeahead({}, {
    name: 'states',
    displayKey: function(row) {return row[0]},
    source: substringMatcher(json.rows)
  })
  .on('typeahead:selected', function($e, row) {
    renderDetails(row)
    var latlng = new google.maps.LatLng(Number(row[4]), Number(row[3]))
    googleMap.setCenter(latlng)
  })
  initMarkers(json, googleMap)
}

function initMap() { 
  var lat = 37.8043637
  var lng = -122.2711137
  var map = new google.maps.Map(document.getElementById("gmap_canvas"), {
    zoom: 16,
    center: new google.maps.LatLng(lat, lng),
    mapTypeId: google.maps.MapTypeId.ROADMAP
  })

  return map
}

function initMarkers(json, map) {
  for(var i = 0; i < json.rows.length; ++i) {
    var row = json.rows[i]
    var latlng = new google.maps.LatLng(Number(row[4]), Number(row[3]))

    var marker = new google.maps.Marker({
      position: latlng,
      map: map,
      title: row[0],
      content: row.slice(0)
    })

    var infowindow = new google.maps.InfoWindow()

    google.maps.event.addListener(marker, 'click', function() {
      infowindow.setContent(this.content[0])
      infowindow.open(map, this)
      renderDetails(this.content)
    })
  }
}
