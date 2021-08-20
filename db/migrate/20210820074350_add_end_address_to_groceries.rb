class AddEndAddressToGroceries < ActiveRecord::Migration[6.0]
  def change
    add_column :groceries, :end_address, :string
  end
end
