class CreateDistances < ActiveRecord::Migration[6.0]
  def change
    create_table :distances do |t|
      t.references :farm_a, index: true, foreign_key: {to_table: :farms}
      t.references :farm_b, index: true, foreign_key: {to_table: :farms}
      t.float :km
      t.float :minutes

      t.timestamps
    end
  end
end
