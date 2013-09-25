
# options
location =
	city: 'Nice'
	country: 'France'
	lat: 43.7034
	lng: 7.2663
url = 'data/' + location.country + '.' + location.city + '.json'

console.log 'requesting "' + url + '"...'

makeMap = (data) ->

	console.log 'init GMaps...'

	# init map
	map = new GMaps
		div: '#map'
		lat: location.lat
		lng: location.lng
		height: window.innerHeight
		width: window.innerWidth

	# center on current location
	GMaps.geolocate
		success: (position) ->
			map.setCenter position.coords.latitude, position.coords.longitude

		error: (error) ->
			console.log 'Geolocation failed: ' + error.message

	# create markers
	makeMarker datum, map for datum in data

makeMarker = (datum, map) ->

	html = """
		<img class="image" src="#{datum.image_url}" />
		<span class="name">#{datum.name}</span>
		<img class="rating" src="#{datum.rating_img_url_small}" />
		<span class="phone">#{datum.display_phone}</span>
		<span class="address">#{datum.location.address[0]}</span>

	"""

	# geocode, load markers
	GMaps.geocode
		address: datum.location.address[0] + ', ' + datum.location.city + ', ' + datum.location.postal_code + ', ' + datum.location.country_code,
		callback: (results, status) ->
			if status is 'OK'

				latlng = results[0].geometry.location

				map.addMarker
					lat: latlng.lat()
					lng: latlng.lng()
					infoWindow:
						content: html

load = (res) ->

	data = JSON.parse res
	console.log data

	makeMap data

# init
uxhr url, null,
	complete: load