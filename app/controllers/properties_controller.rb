class PropertiesController < ApplicationController
  def index
    @propiedades = Property.find(:all)
    @propiedad = Property.new
  end

  def new
    @propiedad = Property.new
  end

  def create
    @propiedad = Property.new(params[:property])
    if @propiedad.save
      redirect_to index_property_path, :notice => "Registrado"
    else
      redirect_to new_property_path, :notice => "Verificar datos"
    end
  end

  def show
    @propiedad = Property.find(params[:id])
  end

  def destroy
    @propiedad = Property.find(params[:id])
    @propiedad.destroy
    redirect_to index_property_path
  end

  def edit
   @propiedad = Property.find(params[:id])
  end

  def update
    @propiedad = Property.find(params[:id])
    @propiedad.update_attributes(params[:property])
    redirect_to index_property_path
  end
end
