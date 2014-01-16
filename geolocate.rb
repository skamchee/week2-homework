require 'uri'
require 'open-uri'
require 'json'

print 'Enter an address, city, or zipcode:'
input = gets.chomp

#create a uri object from a string
uriObj = URI.parse('http://maps.googleapis.com/maps/api/geocode/json')
#add query parameters to the URI. Encode parameters (in case there are special characters or spaces)
uriObj.query = URI.encode_www_form('address' => input, 'sensor' => 'false')

json_data = open(uriObj.to_s).read
data = JSON.parse(json_data)

if data["status"]=='OK'
  printf "Latitude: %8f\n" % data["results"][0]["geometry"]["location"]["lat"]
  printf "Longitude: %8f\n" % data["results"][0]["geometry"]["location"]["lng"]
elsif data["status"]=="ZERO_RESULTS"
  puts "No locations found that matched your input"
else
  puts "Error, please try again"
end
