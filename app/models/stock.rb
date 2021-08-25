class Stock < ApplicationRecord
  belongs_to :farm
  belongs_to :product

  def self.generating_random(farm_a, range = (10..40))
    Product.all.sample(range.to_a.sample).each do |product|
      Stock.new(
        farm_id: farm_a.id,
        product_id: product.id
      ).save
    end
  end
end
