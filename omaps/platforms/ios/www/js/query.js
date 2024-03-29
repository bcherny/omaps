// Generated by CoffeeScript 1.6.3
(function() {
  var client, fs, location, options, output, process, writeError, yelp, _;

  _ = require('lodash');

  fs = require('fs');

  yelp = require('yelp');

  location = 'Nice, France';

  output = '../' + location + '.json';

  client = yelp.createClient({
    consumer_key: 'X1SJnBfMDjbNTqnDCRwBYQ',
    consumer_secret: 'sTuLgPyQjAhP5WJ08umLwA4Rprg',
    token: 'u91du_krF8T_6uC3LM9JRJ35vBwUa8Cq',
    token_secret: 'Lk6b6GnlAtibkBG5t1jZiJUcDWI'
  });

  options = {
    category_filter: 'food',
    location: location
  };

  process = function(error, data) {
    var asString, places;
    console.log('downloaded!');
    places = _.reject(data.businesses, function(datum) {
      return datum.rating < 4 || datum.review_count < 10;
    });
    console.log('stringifying...');
    asString = JSON.stringify(places, null, 4);
    console.log('writing...');
    return fs.writeFile(output, asString, writeError);
  };

  writeError = function(error) {
    if (error) {
      throw new Error(error);
    } else {
      return console.log('saved data to "' + output + '"!');
    }
  };

  client.search(options, process);

}).call(this);
