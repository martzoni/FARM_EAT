class Farm < ApplicationRecord
  belongs_to :user
  has_many :stocks, dependent: :destroy
  has_many :products, through: :stocks
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :photo

  # black magic (Everysky)
  def self.available_farms(grocery_products_list)
    farms = []
    Farm.all.each do |farm|
    #      ou
    # self.all.each do |f|
      found = false
      index = 0
      until found == true || index == grocery_products_list.size do
        found = true if farm.products.where(id: grocery_products_list[index].id).any?
        # puts grocery_products_list[index].name if found
        # puts farm.id if found
        index += 1
      end
      farms << farm if found
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
