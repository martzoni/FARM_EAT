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
    unavailable_products = self.products - grocery_product_list
    # liste de travail des produits restant à acheter 
    products_left_to_buy = grocery_product_list
    puts "produits à acheter: #{products_left_to_buy.count}"
    puts products_left_to_buy.map{ |a| a.name}
    # liste de travail qui va stocker les achats aux differentes fermes
    list_achats = []
    list_farms = []
    # liste de travail qui stockera la suites de coordonnees
    trajet = []
    puts self.start_address
    start_coordinates = Geocoder.search(self.start_address).first.coordinates.reverse
    trajet << start_coordinates
    # boucle de la mort
    puts "debut de boucle"
    until products_left_to_buy.size == 0 do
      puts "debut d'iteration"
      # get a farm
      farm = Farm.available_farms(products_left_to_buy).first
      puts "farm id: #{farm.id}"
      # add farm coordinates to trajet (si les coordonees ne sont pas nulles)
      puts farm.coordinates_2
      trajet << farm.coordinates_2 unless farm.coordinates_2 == nil
      puts "trajet: #{trajet.count}"
      puts trajet
      # add farm id to list of farms
      list_farms << farm
      # buy all you need
      achats = farm.buy_all_products_needed(products_left_to_buy)
      puts "achats: #{achats.count}"
      puts achats.map{ |a| a.name}
      # add buys to list
      list_achats << achats
      # enlever les achats de la liste des produits a acheter
      products_left_to_buy = products_left_to_buy - achats
      puts "produits restant à acheter: #{products_left_to_buy.count}"
      puts products_left_to_buy.map{ |a| a.name}
      puts "fin d'iteration"
      puts "------------"
    end
    # puts "fin de boucle"
    if self.end_address == nil
      end_coodinates = start_coordinates
    else
      end_coodinates = Geocoder.search(self.end_address).first.coordinates.reverse
    end
    trajet << end_coodinates
    resultat = [trajet, list_farms, list_achats, unavailable_products]
    return resultat
  end

  def get_best_path
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
  end

  def self.generating_random(nbr)
    nbr.times do
      # creer une course
      grocery = Grocery.new(
        user_id: User.all.sample.id,
        start_address: [
          "Chemin du Closel 5, 1020 Renens",
          "Av. des Mousquines, 1005 Lausanne",
          "Quai Perdonnet 19, 1800 Vevey",
          "Rue du Sablon 2, 1110 Morges",
          "Place de la Palud 2 · 1003 Lausanne",
          "Rue du Simplon 16, 1800 Vevey"
        ].sample,
        end_address: [
          "Chemin de Publoz 32, 1070 Puidoux",
          "chemin du Pré de l'Essert 6, 1072 Forel (Lavaux)",
          "Chemin de la Villaire 10, 1040 Echallens",
          "Chemin Prés-du-Dimanche 16, 1304 Cossonay",
          "12C Chemin de beree, 1010 Lausanne"
        ].sample
      ).save
      # y ajouter des produits
      products = Product.all.sample(5)
      grocery = Grocery.all.last
      products.each do |p|
        GroceryProduct.new(
          grocery_id: grocery.id,
          product_id: p.id
        ).save
      end
    end
  end
end
