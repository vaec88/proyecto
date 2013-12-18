class UsuariosController < ApplicationController
  def index
    @personas = Persona.joins(:usuarios).where(:personas_roles_usuarios => {:role_id => '2'})    
  end
  
  def new
    @user = Usuario.new
    @person = Persona.new
  end

  def create
    @user = Usuario.new(params[:usuario])
    @person = Persona.new(params[:persona])
    #@person = @user.personas.build(params[:persona])
    if @user.save and @person.save
      p_id = @person.id
      u_id = @user.id
      @per_rol_usu = PersonasRolesUsuario.new(:persona_id => p_id, :role_id => '2', :usuario_id => u_id)
      @per_rol_usu.save
      redirect_to index_usuarios_path, :notice => "Registrado"
    else
      put "Datos mal ingresados"
      #render "new"
    end
  end

  def edit
    @user = Usuario.find(params[:usuario_id])
    @person = Persona.find(params[:persona_id])
  end

  def update
    @user = Usuario.find(params[:id])
    @person = Persona.find(params[:id])
    @user.update_attributes(params[:usuario])
    @person.update_attributes(params[:persona])
    rol = Role.find(current_rol)
    if rol.rol_nombre == "Administrador"
      redirect_to index_usuarios_path
    else
      redirect_to index_construction_path
    end
    
  end
end