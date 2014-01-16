require 'uri'
require 'open-uri'
require 'json'

print 'Enter an address, city, or zipcode:'
input = gets.chomp

#create a uri object from a string
uriLatLng = URI.parse('http://maps.googleapis.com/maps/api/geocode/json')
#add query parameters to the URI. Encode parameters (in case there are special characters or spaces)
uriLatLng.query = URI.encode_www_form('address' => input, 'sensor' => 'false')

json_data = open(uriLatLng.to_s).read
data = JSON.parse(json_data)

if data["status"]=='OK'
  lat = data["results"][0]["geometry"]["location"]["lat"].to_s
  lng = data["results"][0]["geometry"]["location"]["lng"].to_s
elsif data["status"]=="ZERO_RESULTS"
  puts "No locations found that matched your input"
  exit
else
  puts "Error, please try again"
  exit
end

uriWeather = URI.parse('http://api.openweathermap.org/data/2.5/weather?')
uriWeather.query = URI.encode_www_form('lat' => lat, 'lon' => lng)
jsonWeatherData = open(uriWeather.to_s).read
weatherData = JSON.parse(jsonWeatherData)

printf "%.1fF\n" % (1.8*(weatherData["main"]["temp"]-273.15)+32)


