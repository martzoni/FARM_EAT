require 'open-uri'

def distance_mapbox(coord_a, coord_b)
  url_trajet = "https://api.mapbox.com/optimized-trips/v1/mapbox/driving/#{coord_a[0]},#{coord_a[1]};#{coord_b[0]},#{coord_b[1]}?roundtrip=false&source=first&destination=last&access_token=pk.eyJ1IjoibWFydHpvbmkiLCJhIjoiY2tyZzVnN2dxMmdqczJ6cDhxOHIyb2t5MSJ9.4pVoyR4PxS3ONhaEGw0xug"
  json_content_trajet = URI.open(url_trajet).read
  # puts json_content_trajet
  code = JSON.parse(json_content_trajet)["code"]
  # puts code
  if code == "Ok"
    km = JSON.parse(json_content_trajet)["trips"].first["distance"].to_f / 1000
    min = JSON.parse(json_content_trajet)["trips"].first["duration"].to_f / 60
    # puts km
    # puts min
    # puts "#{km} km"
    # puts "#{min} minutes"
    return [km, min]
  else
    return nil
  end
end

def generate_google_maps_url(grocery, farms)
  # chemin%20du%20Closel%205,%20Renens/Route%20de%20la%20Goille%2013,%20Savigny/Sur%20Broye,%20Bossonnens/Rue%20Blanchoud%204,%20Vevey
  waypoints = farms.empty? ? "" : farms.map{ |e| "#{e.address}/" }.join
  addresses = "#{grocery.start_address}/#{waypoints}#{grocery.end_address}"
  return "https://www.google.ch/maps/dir/#{addresses}"
end