class ParametersController < ApplicationController
  def index
    @parametros = Parameter.find(:all)
    @parametro = Parameter.new
  end

  def new
    @parametro = Parameter.new
  end

  def create
    @parametro = Parameter.new(params[:parameter])
    if @parametro.save
      redirect_to index_parameter_path, :notice => "Registrado"
    else
      redirect_to new_parameter_path, :notice => "Verificar datos"
    end
  end

  def show
    @parametro = Parameter.find(params[:id])
    @descripcion = Description.joins(:parameters).where(:parameters => {:id => @parametro.id})
  end

  def destroy
    @parametro = Parameter.find(params[:id])
    #@parametro.parameters_descriptions.find(params[:id])
    @parametro.destroy
    redirect_to index_parameter_path
  end

  def edit
   @parametro = Parameter.find(params[:id])
  end

  def update
    @parametro = Parameter.find(params[:id])
    params[:parameter][:description_ids]||=[]
    @parametro.update_attributes(params[:parameter])
    redirect_to index_parameter_path
  end
end
