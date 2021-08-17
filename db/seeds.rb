# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'nokogiri'

url = "https://www.conservation-nature.fr/food/fruits/"

html_content = URI.open(url).read
doc = Nokogiri::HTML(html_content)

fruits = []
doc.search('.int-plante-tab h3').each do |element|
  Product.new(name: element).save
end