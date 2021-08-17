class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name

      t.timestamps
    end
    add_reference :stocks, :product, foreign_key: true
  end
end
