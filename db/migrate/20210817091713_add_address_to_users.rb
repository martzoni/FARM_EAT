class AddAddressToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :address, :string
    add_column :users, :name, :string
    add_column :users, :is_farmer, :boolean
  end
end
