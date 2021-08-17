class AddUserIdToFarms < ActiveRecord::Migration[6.0]
  def change
    add_reference :farms, :user, null: false, foreign_key: true
  end
end
