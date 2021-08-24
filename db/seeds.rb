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
Farm.destroy_all
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
nbr_groceries = Grocery.all.count
if nbr_groceries == 0
  puts "creating groceries"
  Grocery.generating_random(4)
else
  puts "#{nbr_groceries} groceries already existing"
end
