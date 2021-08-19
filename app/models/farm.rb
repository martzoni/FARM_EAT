class Farm < ApplicationRecord
  belongs_to :user
  has_many :stocks, dependent: :destroy
  has_many :products, through: :stocks
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :photo

  # black magic (Everysky)
  def self.available_farms(products_list)
    farms = []
    Farm.all.each do |farm|
    #      ou
    # self.all.each do |f|
      puts "farm"
      puts farm
      found = false
      index = 0
      farm_products = farm.products.to_a
      puts farm_products.map{ |e| e.name}
      puts "-----list-----"
      puts products_list.map{ |e| e.name}
      # puts products_list.size
      until found == true || index == products_list.size do
        # puts "hello"
        # puts index
        found = true if farm_products.include?(products_list[index])
        index += 1
        # puts found
        # puts farms
      end
      puts "-----"
      puts found
      farms << farm if found == true
      # puts farms
    end
    return farms
  end

  def buy_all_products_needed(grocery_products_list)
    #       je voulais faire ça à la base
    # self.products.intersection(grocery_products_list)
    #       mais Alain m'a conseillé de faire cette requete SQL (beaucoup plus rapide)
    self.products.where("products.id in (?)", grocery_products_list.map(&:id))
  end
end
