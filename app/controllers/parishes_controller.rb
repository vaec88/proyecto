class ParishesController < ApplicationController
  def index
    @id = params[:canton_id]
    @canton = Canton.find(@id)
    @province = Province.find(@canton.province_id)
    @parroquias = Parish.joins(:canton).where(:canton_id=>@id)
    @parroquia = Parish.new
  end

  def new
    @parroquia = Parish.new
    @id = params[:canton_id]
  end

  def create
    @parroquia = Parish.new(params[:parish])
    if @parroquia.save
      redirect_to index_parish_path(:canton_id => @parroquia.canton_id), :notice => "Registrado"
    else
      redirect_to new_parish_path, :notice => "Verificar datos"
    end
  end

  def show
    @parroquia = Parish.find(params[:id])
  end

  def destroy
    @parroquia = Parish.find(params[:id])
    @parroquia.destroy
    redirect_to index_parish_path(:canton_id => @parroquia.canton_id)
  end

  def edit
   @parroquia = Parish.find(params[:id])
  end

  def update
    @parroquia = Parish.find(params[:id])
    @parroquia.update_attributes(params[:parish])
    redirect_to index_parish_path(:canton_id => @parroquia.canton_id)
  end
end
