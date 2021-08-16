class GroceryProduct < ApplicationRecord
  belongs_to :product
  belongs_to :grocery
end
