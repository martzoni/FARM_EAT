class StocksController < ApplicationController
  before_action :find_stock, only: [:show]

  def index
    @stocks = Stock.all
  end

  def show
    
  end

  def new
    @stock = Stock.new()
    @farm = Farm.find(params[:farm_id])
    @products = Product.all
  end

  def create
    @stock = Stock.new(stock_params)
    @stock.farm = Farm.find(params[:farm_id])
    @stock.save
    @stock = Stock.new()
    @farm = Farm.find(params[:farm_id])
    @products = Product.all
		render :new

  end

  def destroy
    @stock = Stock.find(params[:id])
    @stock.destroy
  end

  private 

  def find_stock
    @stock = Stock.find(params[:id])
  end

  def stock_params
    params.require(:stock).permit(:in_stock_today, :season, :product_id)
  end
end
