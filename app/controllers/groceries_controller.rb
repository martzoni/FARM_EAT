class GroceriesController < ApplicationController
  # load '../algorithms/get_a_path.rb'
  def index
    @groceries = Grocery.all
  end

  def show
    @grocery = Grocery.find(params[:id])
    
  end

  def new
    @grocery = Grocery.new
  end

  def create
    @grocery = Grocery.new(grocery_params)
    @grocery.user = current_user if user_signed_in?
    if @grocery.save
      redirect_to show_path(@grocery)
    else
      render :new
    end
  end

  private

  def grocery_params
  params.require(:grocery).permit()
  end

  # black magic (Everysky)
  # def available_farms(products_list)
  #   farms = []
  #   Farm.all.each do |f|
  #     found = false
  #     count = 0
  #     until found == true || count == f.products.size do
  #       # puts count
  #       found = true if f.products.include?(products_list[count])
  #       count += 1
  #       # puts found
  #       # puts farms
  #     end
  #     farms << f if found == true
  #   end
  #   return farms
  # end
end