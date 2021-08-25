class GroceriesController < ApplicationController
  # load '../algorithms/get_a_path.rb'
  before_action :authenticate_user!, only: [:new, :create, :my_groceries]

  def index
    @groceries = Grocery.all
    @my_groceries = current_user.groceries.select{ |grocery| grocery.start_address != nil }
  end

  def show
    range = 20
    @grocery = Grocery.find(params[:id])
    @resultat = @grocery.get_a_better_path(range)
    @trajet = @resultat[0]
    @farms = @resultat[1]
    @achats = @resultat[2]
    @unavailable_products = @resultat[3]
  end

  def new
    @grocery = Grocery.new()
    @grocery.user = current_user
    @start_address = @grocery.user.address
    if @grocery.save
      redirect_to new_grocery_grocery_product_path(@grocery)
    else
      render :new
    end
  end

  def create
  end

  def update
    @grocery = Grocery.find(params[:id])
    @grocery.assign_attributes(grocery_params)
    if @grocery.start_address.empty?
      redirect_to new_grocery_grocery_product_path(@grocery), notice: "Merci de renseigner l'adresse de depart!"
    else
      @grocery.update(grocery_params)
      redirect_to grocery_path(@grocery)
    end
  end

  def my_groceries
    @my_groceries = current_user.groceries
  end

  private

  def grocery_params
  params.require(:grocery).permit(:start_address, :end_address)
  end
  
  # require 'open-uri'

  # def distance_mapbox(coord_a, coord_b)
  #   url_trajet = "https://api.mapbox.com/optimized-trips/v1/mapbox/driving/#{coord_a[0]},#{coord_a[1]};#{coord_b[0]},#{coord_b[1]}?roundtrip=false&source=first&destination=last&access_token=pk.eyJ1IjoibWFydHpvbmkiLCJhIjoiY2tyZzVnN2dxMmdqczJ6cDhxOHIyb2t5MSJ9.4pVoyR4PxS3ONhaEGw0xug"
  #   json_content_trajet = URI.open(url_trajet).read
  #   # puts json_content_trajet
  #   code = JSON.parse(json_content_trajet)["code"]
  #   # puts code
  #   if code == "Ok"
  #     km = JSON.parse(json_content_trajet)["trips"].first["distance"].to_f / 1000
  #     min = JSON.parse(json_content_trajet)["trips"].first["duration"].to_f / 60
  #     # puts km
  #     # puts min
  #     puts "#{km} km"
  #     puts "#{min} minutes"
  #     return [km, min]
  #   else
  #     return nil
  #   end
  # end

  def mapboox_url_pour_trajet(trajet)
    trajet_string = trajet.map{|a| "#{a[0]},#{a[1]}"}.join(";")
    url_trajet = "https://api.mapbox.com/optimized-trips/v1/mapbox/driving/#{trajet_string}?geometries=geojson&roundtrip=false&source=first&destination=last&access_token=pk.eyJ1IjoibWFydHpvbmkiLCJhIjoiY2tyZzVnN2dxMmdqczJ6cDhxOHIyb2t5MSJ9.4pVoyR4PxS3ONhaEGw0xug"
    return url_trajet
  end

end