class AddStartAddressToGroceries < ActiveRecord::Migration[6.0]
  def change
    add_column :groceries, :start_address, :string
  end
end
