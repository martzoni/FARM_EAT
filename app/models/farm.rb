class Farm < ApplicationRecord
  belongs_to :user
  has_many :stocks, dependent: :destroy
  # has_many :distances, dependent: :destroy
  has_many :products, through: :stocks
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :photo

  # black magic (Everysky)
  def self.available_farms(grocery_products_list)
    farms = []
    Farm.all.each do |farm|
    #      ou
    # self.all.each do |farm|
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

  def coordinates_2
    if self.longitude == nil || self.latitude == nil
      return nil
    else
      return [self.longitude, self.latitude]
    end
  end

  require 'open-uri'
  require 'nokogiri'

  def self.scraping
    puts "Scraping for farms..."
    url_farm = "https://www.marchepaysan.ch/index.php/producteur"
  
    html_content_farm = URI.open(url_farm).read
    doc_farm = Nokogiri::HTML(html_content_farm)
  
    doc_farm.search('.item-name').each do |card_info|
      farm_a = Farm.new()
      farm_a.name = card_info.search('span')[1].text
      link = card_info.css('a').attribute('href')
  
      html_content_details = URI.open(link).read
      doc_details = Nokogiri::HTML(html_content_details)
  
      farm_a.address = doc_details.search('.company-info-details p').text.strip
      farm_a.phone = doc_details.search('.company-info-details .phone a').text.strip
      attributes = doc_details.search('.listing-attributes')
      content_attributes = attributes.map do |att|
        "#{att.search('.attribute-name').text.strip.delete "\r"} #{att.search('.attribute-item').text.strip.delete "\r"}"
      end
      farm_a.content = content_attributes.join("\r")
      # f.content = "Lorem ipsum, dolor sit amet consectetur adipisicing elit. At numquam debitis, ex dolor nobis, tempora accusantium repudiandae quo vitae officia distinctio asperiores sed esse blanditiis iure sit, vero sapiente ea."
      farm_a.user_id = User.all.sample.id
      farm_a.email = farm_a.user.email
      file = URI.open('http://loremflickr.com/800/600/farm')
      farm_a.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
      # puts f
      farm_a.save
      # puts farm_a
      # puts farm_a.coordinates

  
      # verification que l'adresse est valide
      if farm_a.coordinates == nil
        puts "in here"
        farm_a.destroy
        puts "invalid address"
      else
        puts "address is valid. proceeding..."
        # creating stock
        Stock.generating_random(farm_a)
        # creating distances
        Distance.tying_up_with_the_others(farm_a)
      end
    end
  end
end