# require 'open-uri'
# require 'json'

# def distance_mapbox(coord_a, coord_b)
#   url_trajet = "https://api.mapbox.com/optimized-trips/v1/mapbox/driving/#{coord_a[0]},#{coord_a[1]};#{coord_b[0]},#{coord_b[1]}?roundtrip=false&source=first&destination=last&access_token=pk.eyJ1IjoibWFydHpvbmkiLCJhIjoiY2tyZzVnN2dxMmdqczJ6cDhxOHIyb2t5MSJ9.4pVoyR4PxS3ONhaEGw0xug"
#   json_content_trajet = URI.open(url_trajet).read
#   # puts json_content_trajet
#   code = JSON.parse(json_content_trajet)["code"]
#   # puts code
#   if code == "Ok"
#     km = JSON.parse(json_content_trajet)["trips"].first["distance"].to_f / 1000
#     min = JSON.parse(json_content_trajet)["trips"].first["duration"].to_f / 60
#     # puts km
#     # puts min
#     puts "#{km} km"
#     puts "#{min} minutes"
#     return [km, min]
#   else
#     return nil
#   end
# end

# Stock.where(farm_id: params[:farm_id]).where(product_id: params[:id]).first

puts Grocery.all.sample.get_a_path