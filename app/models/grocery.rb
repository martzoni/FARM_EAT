class Grocery < ApplicationRecord
  belongs_to :user
  has_many :grocery_products, dependent: :destroy
end
