class Product < ApplicationRecord
  has_many :stocks, dependent: :destroy
  has_many :grocery_products, dependent: :destroy

  def self.list_all_names
    all.map { |e| e.name }
  end
end
