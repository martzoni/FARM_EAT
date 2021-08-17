class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.references :farm, null: false, foreign_key: true
      t.boolean :in_stock_today
      t.boolean :season

      t.timestamps
    end
  end
end
