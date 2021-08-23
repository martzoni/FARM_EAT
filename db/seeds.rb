# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'nokogiri'
require 'faker'
# require 'csv'


# Creation des users
# if User.all.count == 0
#   if 

# creation des produits

# Start seeding
puts "Cleaning database..."
# Product.destroy_all
# User.destroy_all
# Stock.destroy_all
# Distance.destroy_all
# Farm.destroy_all
Grocery.destroy_all

# creating products
nbr_products = Product.all.count
if nbr_products == 0
  Product.fruits_scraping
  Product.legumes_scraping
else
  puts "#{nbr_products} products already existing"
end

# creating users
nbr_users = User.all.count
if nbr_users == 0
  User.generating_the_team
  User.generating_random(15)
else
  puts "#{nbr_users} users already existing"
end

# creating farms
nbr_farms = Farm.all.count
if nbr_farms == 0
  Farm.scraping
else
  puts "#{nbr_farms} farms already existing"
end

# generating a grocery
puts "creating groceries"
4.times do
  # creer une course
  grocery = Grocery.new(
    user_id: User.all.sample.id,
    start_address: [
      "Chem. du Closel 5, 1020 Renens",
      "Av. des Mousquines, 1005 Lausanne",
      "Quai Perdonnet 19, 1800 Vevey",
      "Rue du Sablon 2, 1110 Morges",
      "Place de la Palud 2 · 1003 Lausanne",
      "Rue du Simplon 16, 1800 Vevey"
    ].sample,
    end_address: [
      "Chem. de Publoz 32, 1070 Puidoux",
      "chemin du Pré de l'Essert 6, 1072 Forel (Lavaux)",
      "Chem. de la Villaire 10, 1040 Echallens",
      "Chem. Prés-du-Dimanche 16, 1304 Cossonay",
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
