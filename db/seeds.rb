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

# Start seeding
puts "Cleaning database..."
Farm.destroy_all
User.destroy_all
Product.destroy_all
# Groceries.destroy_all
Stock.destroy_all

# creating products
puts "Parsing for products..."
url_product = "https://www.conservation-nature.fr/food/fruits/"

html_content_product = URI.open(url_product).read
doc_product = Nokogiri::HTML(html_content_product)

doc_product.search('.int-plante-tab h3').each do |element|
  Product.new(name: element.text.strip).save
end

# creating users
puts "Creating 3 users..."
user = User.new(
  name: "Martin",
  email: "martin@gmail.com",
  password: "123456",
  is_farmer: false
)
user.save!
user = User.new(
  name: "Pablo",
  email: "pablo@gmail.com",
  password: "123456",
  is_farmer: false
)
user.save!
user = User.new(
  name: "Oscar",
  email: "oscar@gmail.com",
  password: "123456",
  is_farmer: false
)
user.save!

# creating more users
puts "Creating 15 farmers..."

15.times do
  user_name = Faker::Name.unique.first_name
  # puts user_name
  user = User.new(
    name: user_name,
    email: "#{user_name}@hotmail.com",
    password: "123456",
    is_farmer: true,
    address: ["Pl. de la Navigation 3, 1006 Lausanne", "Bouveret1897 Port-Valais", "Quai Perdonnet 19, 1800 Vevey", "Quai de Cologny 1, 1223 Cologny", "12C Chemin de beree, 1010 Lausanne", "Chemin des Esserts 5, 1024 Ecublens", "Place de la Palud 2 · 1003 Lausanne", "Rue du Simplon 16, 1800 Vevey", "Case Postale 1125, 1001 Lausanne", "Ouchy 60, 1006 Lausanne", "Grand' Rue 73, 1820 Montreux", "Av. de la Gare 33, 1618 Châtel-Saint-Denis", "Rte de Lausanne 16, 1052 Le Mont-sur-Lausanne", "Pl. de l'Hôtel-de-Ville 1, 1110 Morges", "Pl. du Château 3, 1260 Nyon"].sample)
  user.save!
end

# creating farms
puts "Parsing for farms..."
url_farm = "https://www.marchepaysan.ch/index.php/producteur"

html_content_farm = URI.open(url_farm).read
doc_farm = Nokogiri::HTML(html_content_farm)

doc_farm.search('.item-name').each do |card_info|
  f = Farm.new()
  f.name = card_info.search('span')[1].text
  link = card_info.css('a').attribute('href')

  html_content_details = URI.open(link).read
  doc_details = Nokogiri::HTML(html_content_details)

  f.address = doc_details.search('.company-info-details p').text.strip
  f.phone = doc_details.search('.company-info-details .phone a').text.strip
  f.content = "Lorem ipsum, dolor sit amet consectetur adipisicing elit. At numquam debitis, ex dolor nobis, tempora accusantium repudiandae quo vitae officia distinctio asperiores sed esse blanditiis iure sit, vero sapiente ea."
  f.user_id = User.all.sample.id
  f.email = f.user.email
  # puts f
  f.save
end

# creating stock
puts "generating stocks"
Farm.all.each do |farm|
  Product.all.sample(10 + rand(30)).each do |product|
    Stock.new(
      farm_id: farm.id,
      product_id: product.id
    ).save
  end
end
