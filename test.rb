require 'open-uri'
require 'json'


url_trajet = "https://api.mapbox.com/optimized-trips/v1/mapbox/driving/6.4216,46.6056;6.475,46.6139?roundtrip=false&source=first&destination=last&access_token=pk.eyJ1IjoibWFydHpvbmkiLCJhIjoiY2tyZzVnN2dxMmdqczJ6cDhxOHIyb2t5MSJ9.4pVoyR4PxS3ONhaEGw0xug"
json_content_trajet = URI.open(url_trajet).read
# puts json_content_trajet
code = JSON.parse(json_content_trajet)["code"]
# puts code
if code == "Ok"
  km = JSON.parse(json_content_trajet)["trips"].first["distance"].to_f / 1000
  min = JSON.parse(json_content_trajet)["trips"].first["duration"].to_f / 60
  # puts km
  # puts min
  puts "#{km} km"
  puts "#{min} minutes"
end
