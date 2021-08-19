class GroceryProductsController < ApplicationController
  before_action :find_stock, only: [:show]

  def index
    @grocery_products = GroceryProduct.all
  end

  def show
    
  end

  def new
    @grocery_product = GroceryProduct.new()
    @grocery = Grocery.find(params[:grocery_id])
    @products = Product.all
  end

  def create
    @grocery_product = GroceryProduct.new(stock_params)
    @grocery_product.grocery = Grocery.find(params[:grocery_id])
    @grocery_product.save

    @grocery_product = GroceryProduct.new()
    @grocery = Grocery.find(params[:grocery_id])
    @products = Product.all
		render :new
  end

  def destroy
    @grocery_product = GroceryProduct.find(params[:id])
    @grocery_product.destroy
  end

  private 

  def find_stock
    @grocery_product = GroceryProduct.find(params[:id])
  end

  def stock_params
    params.require(:grocery_product).permit(:product_id)
  end
end
