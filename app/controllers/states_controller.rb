class StatesController < ApplicationController
  def index
    @id = params[:rebate_id]
    @rebate = Rebate.find(@id)
    @estados = State.joins(:rebate).where(:rebate_id=>@id)
    @estado = State.new
  end

  def new
    @estado = State.new
    @id = params[:rebate_id]
  end

  def create
    @estado = State.new(params[:state])
    if @estado.save
      redirect_to index_state_path(:rebate_id => @estado.rebate_id), :notice => "Registrado"
    else
      redirect_to new_state_path, :notice => "Verificar datos"
    end
  end

  def show
    @estado = State.find(params[:id])
  end

  def destroy
    @estado = State.find(params[:id])
    @estado.destroy
    redirect_to index_state_path(:rebate_id => @estado.rebate_id)
  end

  def edit
   @estado = State.find(params[:id])
  end

  def update
    @estado = State.find(params[:id])
    @estado.update_attributes(params[:state])
    redirect_to index_state_path(:rebate_id => @estado.rebate_id)
  end
end
