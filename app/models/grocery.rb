class Grocery < ApplicationRecord
  belongs_to :user
  has_many :grocery_products, dependent: :destroy
  has_many :products, through: :grocery_products


  # black magic 
  def available_products
    available = []
    self.products.each do |p|
      available << p if Stock.where(product: p).any?
    end
    return available
  end

  def get_a_path
    # list de course initiale
    grocery_product_list = self.available_products
    # liste de travail des produits restant à acheter 
    products_left_to_buy = grocery_product_list
    # puts "produits à acheter: #{products_left_to_buy.count}"
    # puts products_left_to_buy.map{ |a| a.name}
    # liste de travail qui va stocker les achats aux differentes fermes
    list_achats = []
    # liste de travail qui stockera la suites de coordonnees
    trajet = []
    start_coordinates = Geocoder.search(self.start_address).first.coordinates.reverse
    trajet << start_coordinates
    # boucle de la mort
    # puts "debut de boucle"
    until products_left_to_buy.size == 0 do
      # puts "debut d'iteration"
      # get a farm
      farm = Farm.available_farms(products_left_to_buy).first
      # puts "farm id: #{farm.id}"
      # add farm coordinates to trajet (si les coordonees ne sont pas nulles)
      # puts farm.coordinates
      trajet << farm.coordinates unless farm.coordinates.first == nil || farm.coordinates.last == nil
      # puts "trajet: #{trajet.count}"
      # puts trajet
      # buy all you need
      achats = farm.buy_all_products_needed(products_left_to_buy)
      # puts "achats: #{achats.count}"
      # puts achats.map{ |a| a.name}
      # add buys to list
      list_achats << achats
      # enlever les achats de la liste des produits a acheter
      products_left_to_buy = products_left_to_buy - achats
      # puts "produits restant à acheter: #{products_left_to_buy.count}"
      # puts products_left_to_buy.map{ |a| a.name}
      # puts "fin d'iteration"
      # puts "------------"
    end
    # puts "fin de boucle"
    if self.end_address == nil
      end_coodinates = start_coordinates
    else
      end_coodinates = Geocoder.search(self.end_address).first.coordinates.reverse
    end
    trajet << end_coodinates
    return trajet
  end

end
