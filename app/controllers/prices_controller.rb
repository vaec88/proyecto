class PricesController < ApplicationController
  def index
    @tablas_avaluos = Price.find(:all)
    @tabla_avaluo = Price.new
  end

  def new
    @tabla_avaluo = Price.new
  end

  def create
    @tabla_avaluo = Price.new(params[:price])
    if @tabla_avaluo.save
      redirect_to index_price_path, :notice => "Registrado"
    else
      redirect_to new_price_path, :notice => "Verificar datos"
    end
  end

  def show
    @tabla_avaluo = Price.find(params[:id])
  end

  def destroy
    @tabla_avaluo = Price.find(params[:id])
    @tabla_avaluo.destroy
    redirect_to index_price_path
  end

  def edit
   @tabla_avaluo = Price.find(params[:id])
  end

  def update
    @tabla_avaluo = Price.find(params[:id])
    @tabla_avaluo.update_attributes(params[:price])
    redirect_to index_price_path
  end
end
