class CreateFarms < ActiveRecord::Migration[6.0]
  def change
    create_table :farms do |t|
      t.string :name
      t.string :address
      t.text :content
      t.string :open_hours
      t.string :phone
      t.string :email
      t.string :web_site

      t.timestamps
    end
  end
end
