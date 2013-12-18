class CantonsController < ApplicationController
  def index
    @id = params[:province_id]
    @province = Province.find(@id)
    @cantones = Canton.joins(:province).where(:province_id=>@id)
    @canton = Canton.new
  end

  def new
    @canton = Canton.new
    @id = params[:province_id]
  end

  def create
    @canton = Canton.new(params[:canton])
    if @canton.save
      redirect_to index_canton_path(:province_id => @canton.province_id), :notice => "Registrado"
    else
      redirect_to new_canton_path, :notice => "Verificar datos"
    end
  end

  def show
    @canton = Canton.find(params[:id])
  end

  def destroy
    @canton = Canton.find(params[:id])
    @canton.destroy
    redirect_to index_canton_path(:province_id => @canton.province_id)
  end

  def edit
   @canton = Canton.find(params[:id])
  end

  def update
    @canton = Canton.find(params[:id])
    @canton.update_attributes(params[:canton])
    redirect_to index_canton_path(:province_id => @canton.province_id)
  end
end
