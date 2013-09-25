
# requires
_ = require 'lodash'
fs = require 'fs'
yelp = require 'yelp'

# options
location = 'Nice, France'
output = '../' + location + '.json'

# setup yelp
client = yelp.createClient
  consumer_key: 'X1SJnBfMDjbNTqnDCRwBYQ',
  consumer_secret: 'sTuLgPyQjAhP5WJ08umLwA4Rprg'
  token: 'u91du_krF8T_6uC3LM9JRJ35vBwUa8Cq'
  token_secret: 'Lk6b6GnlAtibkBG5t1jZiJUcDWI'

options =
	category_filter: 'food'
	location: location

process = (error, data) ->

	console.log 'downloaded!'

	places = _.reject data.businesses, (datum) ->
		datum.rating < 4 or datum.review_count < 10

	console.log 'stringifying...'

	asString = JSON.stringify places, null, 4

	console.log 'writing...'

	fs.writeFile output, asString, writeError

writeError = (error) ->

	if error
	then throw new Error error

	else console.log 'saved data to "' + output + '"!'

# query
client.search options, process