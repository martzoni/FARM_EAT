class CreateGroceryProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :grocery_products do |t|
      t.references :product, null: false, foreign_key: true
      t.references :grocery, null: false, foreign_key: true

      t.timestamps
    end
  end
end
