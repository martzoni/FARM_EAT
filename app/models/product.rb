class Product < ApplicationRecord
  has_many :stocks, dependent: :destroy
  has_many :grocery_products, dependent: :destroy
  has_many :farms, through: :stocks

  def self.list_all_names
    all.map { |e| e.name }
  end

  require 'open-uri'
  require 'nokogiri'
  
  def self.fruits_scraping
    puts "Parsing for products (fruits)..."
    url_product = "https://www.conservation-nature.fr/food/fruits/"

    html_content_product = URI.open(url_product).read
    doc_product = Nokogiri::HTML(html_content_product)

    doc_product.search('.int-plante-tab h3').each do |element|
      self.new(name: element.text.strip, category: "fruit").save
    end
  end
  
  def self.fruits_seeding
    puts "creating fruits"
    fruits = [
      "Abricot",
      "Cerise",
      "Groseille rouge",
      "Fraise",
      "Framboise",
      "Maquereau",
      "Mûre",
      "Nectarine",
      "Pêche",
      "Poire",
      "Pomme",
      "Pruneau"
    ]
    fruits.each do |name|
      self.new(name: name, category: "fruit").save
    end
  end
  

  def self.legumes_scraping
    puts "Parsing for products (légumes)..."
    url_product = "https://www.gemuese.ch/Legumes/Especes-de-legumes"

    html_content_product = URI.open(url_product).read
    doc_product = Nokogiri::HTML(html_content_product)

    doc_product.search('.vegetable-wrapper h2').each do |element|
      self.new(name: element.text.strip, category: "légume").save
    end
  end

end
