class RolesController < ApplicationController
  def new
    @role = Role.new
  end

  def create
    @role = Role.new(params[:role])
    if @role.save
      redirect_to index_role_path, :notice => "Registrado"
    else
      redirect_to new_role_path, :notice => "Verificar datos"
    end
  end

  def index
    @roles = Role.find(:all)
    @role = Role.new
  end
  
  def show
    @roles = Role.find(params[:id])
  end

  def destroy
    @role= Role.find(params[:id])
    @role.destroy
    redirect_to index_role_path
  end

  def edit
   @roles= Role.find(params[:id])
  end

  def update
    @role= Role.find (params[:id])
    @role.update_attributes(params[:role])
    redirect_to index_role_path
  end

end