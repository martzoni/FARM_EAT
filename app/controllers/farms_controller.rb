class FarmsController < ApplicationController
  
  def index
    @farms = Farm.all
    if params[:address] == nil || params[:address].empty?
      @farms = Farm.all
    else
      @farms = Farm.near(params[:address], 10)
    end
    @markers = @farms.geocoded.map do |farm|
      {
        lat: farm.latitude,
        lng: farm.longitude
      }
    end
  end

  def show
    @farm = Farm.find(params[:id])
    @markers = [{
      lat: @farm.latitude,
      lng: @farm.longitude
    }]
  end

  def new
    @farm = Farm.new
  end

  def create
    @farm = Farm.new(farm_params)
    @farm.user = current_user
    if @farm.save
      redirect_to farm_path(@farm)
    else
      render :new
    end
  end

  def edit
    @farm = Farm.find(params[:id])
  end

  def update
    @farm = Farm.find(params[:id])
    @farm.update(farm_params)
    redirect_to farm_path(@farm)
  end

  def destroy
    @farm = Farm.find(params[:id])
    @farm.destroy
    redirect_to my_farms_path
  end

  def my_farms
    @my_farms = current_user.farms
  end

  private

  def farm_params
    params.require(:farm).permit(:name, :address, :content, :open_hours, :phone, :email, :web_site, :photo)
  end
end
