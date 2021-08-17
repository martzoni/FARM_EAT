class Product < ApplicationRecord
  has_many :stocks, dependent: :destroy
  has_many :grocery_products, dependent: :destroy
end
