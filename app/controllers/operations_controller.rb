class OperationsController < ApplicationController
  def index
    @operaciones = Operation.find(:all)
    @operacion = Operation.new
  end

  def new
    @operacion = Operation.new
  end

  def create
    @operacion = Operation.new(params[:operation])
    if @operacion.save
      redirect_to index_operation_path, :notice => "Registrado"
    else
      redirect_to new_operation_path, :notice => "Verificar datos"
    end
  end

  def show
    @operacion = Operation.find(params[:id])
  end

  def destroy
    @operacion = Operation.find(params[:id])
    @operacion.destroy
    redirect_to index_operation_path
  end

  def edit
   @operacion = Operation.find(params[:id])
  end

  def update
    @operacion = Operation.find(params[:id])
    @operacion.update_attributes(params[:operation])
    redirect_to index_operation_path
  end
end
