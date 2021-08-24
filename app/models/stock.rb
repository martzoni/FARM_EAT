class Stock < ApplicationRecord
  belongs_to :farm
  belongs_to :product

  def self.generating_random(farm_a)
    Product.all.sample(10 + rand(30)).each do |product|
      Stock.new(
        farm_id: farm_a.id,
        product_id: product.id
      ).save
    end
  end
end
