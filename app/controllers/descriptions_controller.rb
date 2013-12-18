class DescriptionsController < ApplicationController
  def index
    @params_vals = Description.find(:all)
    @param_val = Description.new
  end

  def new
    @param_val = Description.new
  end

  def create
    @param_val = Description.new(params[:description])
    if @param_val.save
      redirect_to index_description_path, :notice => "Registrado"
    else
      redirect_to new_description_path, :notice => "Verificar datos"
    end
  end

  def show
    @param_val = Description.find(params[:id])
  end

  def destroy
    @param_val = Description.find(params[:id])
#    @det = ParametersDescription.where(:description_id => @param_val.id)
#    @det.each do |d|
#      d.destroy
#    end
    #@param_val=@param_val.parameters_descriptions.find(params[:id])
    #@param_val = Description.includes(:parameters_descriptions).find(params[:id])
    @param_val.destroy
    
    redirect_to index_description_path
  end

  def edit
   @param_val = Description.find(params[:id])
  end

  def update
    @param_val = Description.find(params[:id])
    @param_val.update_attributes(params[:description])
    redirect_to index_description_path
  end
end
