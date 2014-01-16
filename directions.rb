require 'uri'
require 'open-uri'
require 'json'

print 'Enter an origin address:'
origin = gets.chomp

print 'Enter a destination address:'
destination = gets.chomp

#create a uri object from a string                                                                     
uriObj = URI.parse('http://maps.googleapis.com/maps/api/directions/json')
#add query parameters to the URI. Encode parameters (in case there are special characters or spaces)     
uriObj.query = URI.encode_www_form('origin' => origin, 'destination' => destination, 'sensor' => 'false')

#for debugging 
#puts uriObj.to_s

json_data = open(uriObj.to_s).read
data = JSON.parse(json_data)

if data["status"]=="OK"
  puts "Total travel time driving: " + data["routes"][0]["legs"][0]["duration"]["text"]
  puts "Total distance traveled: " + data["routes"][0]["legs"][0]["distance"]["text"]
elsif data["status"]=="NOT_FOUND"
  puts "At least one of the locations could not be found"
elsif data["status"]=="ZERO_RESULTS"
  puts "No potential routes found"
else 
  puts "Error, please try again"
end
