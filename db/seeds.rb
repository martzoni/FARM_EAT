# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'nokogiri'

# parsing for products
# url_product = "https://www.conservation-nature.fr/food/fruits/"

# html_content_product = URI.open(url_product).read
# doc_product = Nokogiri::HTML(html_content_product)

# doc_product.search('.int-plante-tab h3').each do |element|
#   Product.new(name: element).save
# end

# parsing for farms
url_farm = "https://www.marchepaysan.ch/index.php/producteur"

html_content_farm = URI.open(url_farm).read
doc_farm = Nokogiri::HTML(html_content_farm)

doc_farm.search('.item-name').each do |card_info|
  # f = Farm.new()
  # f.name = card_info.search('h3')
  # f.address = card_info.search('.point-subtitle')
  # f.save
  puts card_info.search('a')['href']
  puts card_info.search('span')[1].text
end