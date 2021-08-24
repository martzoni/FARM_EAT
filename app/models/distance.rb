require './app/other_methods.rb'

class Distance < ApplicationRecord
  belongs_to :farm_a, class_name: 'Farm'
  belongs_to :farm_b, class_name: 'Farm'
  # , foreign_key: 'farm_a_id'

  def self.tying_up_with_the_others(farm_b)
    Farm.all.each do |farm_a|
      unless farm_b == farm_a
        distance = Distance.new()
        distance.farm_a_id = farm_a.id
        distance.farm_b_id = farm_b.id
        # puts farm_a.coordinates
        # puts farm_b.coordinates
        trajet_mapbox = distance_mapbox(farm_a.coordinates_2, farm_b.coordinates_2)
        if trajet_mapbox == nil
          distance = nil
          puts "error while creating distance between farms"
        else
          distance.km = trajet_mapbox[0]
          distance.minutes = trajet_mapbox[1]
          distance.save!
          puts "distance created"
        end
      end
    end
  end
end
