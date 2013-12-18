class RebatesController < ApplicationController
  def index
    @depreciaciones = Rebate.find(:all)
    @depreciacion = Rebate.new
  end

  def new
    @depreciacion = Rebate.new
  end

  def create
    @depreciacion = Rebate.new(params[:rebate])
    if @depreciacion.save
      redirect_to index_rebate_path, :notice => "Registrado"
    else
      redirect_to new_rebate_path, :notice => "Verificar datos"
    end
  end

  def show
    @depreciacion = Rebate.find(params[:id])
  end

  def destroy
    @depreciacion = Rebate.find(params[:id])
    @depreciacion.destroy
    redirect_to index_rebate_path
  end

  def edit
   @depreciacion = Rebate.find(params[:id])
  end

  def update
    @depreciacion = Rebate.find(params[:id])
    @depreciacion.update_attributes(params[:rebate])
    redirect_to index_rebate_path
  end
end
