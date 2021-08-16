class Stock < ApplicationRecord
  belongs_to :farm
  belongs_to :product
end
