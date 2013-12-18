class ProvincesController < ApplicationController
  def index
    @provincias = Province.find(:all)
    @provincia = Province.new
  end

  def new
    @provincia = Province.new
  end

  def create
    @provincia = Province.new(params[:province])
    if @provincia.save
      redirect_to index_province_path, :notice => "Registrado"
    else
      redirect_to new_province_path, :notice => "Verificar datos"
    end
  end

  def show
    @provincia = Province.find(params[:id])
  end

  def destroy
    @provincia = Province.find(params[:id])
    @provincia.destroy
    redirect_to index_province_path
  end

  def edit
   @provincia = Province.find(params[:id])
  end

  def update
    @provincia = Province.find(params[:id])
    @provincia.update_attributes(params[:province])
    redirect_to index_province_path
  end
end