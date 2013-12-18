class HonorariesController < ApplicationController
  def index
    @honorarios = Honorary.where(:construction_id => params[:construction_id])
    @inmueble = Construction.find(params[:construction_id])
    @honorario = Honorary.new
  end

  def new
    @honorario = Honorary.new
    @inmueble = Construction.find(params[:construction_id])
  end

  def create
    @honorario = Honorary.new(params[:honorary])
    id = params[:construction_id]
    @honorario.construction_id = id
    if @honorario.save
      redirect_to index_honorary_path(:construction_id => id), :notice => "Registro de abono guardado con exito"
    else
      redirect_to new_honorary_path, :notice => "Verificar datos"
    end
  end

#  def show
#    @honorario = Honorary.find(params[:id])
#  end

  def destroy
    @honorario = Honorary.find(params[:id])
    @honorario.destroy
    redirect_to index_honorary_path(:construction_id => @honorario.construction_id)
  end

  def edit
   @honorario = Honorary.find(params[:id])
  end

  def update
    @honorario = Honorary.find(params[:id])
    @honorario.update_attributes(params[:honorary])
    redirect_to index_honorary_path(:construction_id => @honorario.construction_id)
  end
end
