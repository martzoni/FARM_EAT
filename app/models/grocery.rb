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
  
end
