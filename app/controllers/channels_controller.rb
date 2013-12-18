class ChannelsController < ApplicationController
  def index
    @captaciones = Channel.find(:all)
    @captacion = Channel.new
  end
  
  def new
    @captacion = Channel.new
  end

  def create
    @captacion = Channel.new(params[:channel])
    if @captacion.save
      redirect_to index_channel_path, :notice => "Registrado"
    else
      redirect_to new_channel_path, :notice => "Verificar datos"
    end
  end

  def show
    @captacion = Channel.find(params[:id])
  end

  def destroy
    @captacion = Channel.find(params[:id])
    @captacion.destroy
    redirect_to index_channel_path
  end

  def edit
   @captacion = Channel.find(params[:id])
  end

  def update
    @captacion = Channel.find (params[:id])
    @captacion.update_attributes(params[:channel])
    redirect_to index_channel_path
  end
end
