class FarmsController < ApplicationController
  def index
    @farms = Farm.all
  end

  def show
    @farm = Farm.find(params[:id])
  end

  def new
    @farm = Farm.new
  end

  def create
    @farm = Farm.new(farm_params)
    @farm.user = current_user
    if @farm.save
      redirect_to show_path(@farm)
    else
      render :new
    end
  end

  private

  def farm_params
  params.require(:farm).permit(:name, :address, :content, :open_hours, :phone, :email, :web_site)
  end
end
