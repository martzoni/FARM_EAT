class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :farms, dependent: :destroy
  has_many :groceries, dependent: :destroy

  require 'faker'

  def self.generating_the_team
    puts "Creating 3 users..."
    user = User.new(
      name: "Martin",
      email: "martin@gmail.com",
      password: "123456",
      is_farmer: false
    )
    user.save!
    user = User.new(
      name: "Pablo",
      email: "pablo@gmail.com",
      password: "123456",
      is_farmer: false
    )
    user.save!
    user = User.new(
      name: "Oscar",
      email: "oscar@gmail.com",
      password: "123456",
      is_farmer: false
    )
    user.save!
  end

  def self.generating_random(nbr)
    puts "Creating #{nbr} farmers..."
    nbr.times do
      user_name = Faker::Name.unique.first_name
      # puts user_name
      user = User.new(
        name: user_name,
        email: "#{user_name}@hotmail.com",
        password: "123456",
        is_farmer: true,
        address: ["Pl. de la Navigation 3, 1006 Lausanne", "Bouveret1897 Port-Valais", "Quai Perdonnet 19, 1800 Vevey", "Quai de Cologny 1, 1223 Cologny", "12C Chemin de beree, 1010 Lausanne", "Chemin des Esserts 5, 1024 Ecublens", "Place de la Palud 2 · 1003 Lausanne", "Rue du Simplon 16, 1800 Vevey", "Case Postale 1125, 1001 Lausanne", "Ouchy 60, 1006 Lausanne", "Grand' Rue 73, 1820 Montreux", "Av. de la Gare 33, 1618 Châtel-Saint-Denis", "Rte de Lausanne 16, 1052 Le Mont-sur-Lausanne", "Pl. de l'Hôtel-de-Ville 1, 1110 Morges", "Pl. du Château 3, 1260 Nyon"].sample)
      user.save!
    end
  end
end
