class GroceriesController < ApplicationController

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
end