class GroceriesController < ApplicationController
  # load '../algorithms/get_a_path.rb'
  def index
    @groceries = Grocery.all
  end

  def show
    @grocery = Grocery.find(params[:id])
    
  end

  def new
    @grocery = Grocery.new()
  end

  def create
    @grocery = Grocery.new()
    @grocery.user = current_user
    @start_address = @grocery.user.address
    if @grocery.save
      redirect_to new_grocery_grocery_product_path(@grocery)
    else
      render :new
    end
  end

  private

  def grocery_params
  params.require(:grocery).permit()
  end

end