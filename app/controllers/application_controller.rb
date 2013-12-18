class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :current_rol
  helper_method :current_person
  helper_method :lista_roles

  private
  def current_user
    @current_user ||= Usuario.find(session[:usuario_id]) if session[:usuario_id]
  end
  def current_person
    @current_person = Persona.joins(:usuarios).where(:personas_roles_usuarios => {:role_id => ['2','1'], :usuario_id => current_user}).first
  end
  def current_rol
    @current_rol = Role.joins(:usuarios).where(:personas_roles_usuarios => {:usuario_id => current_user, :persona_id => current_person})
    #@current_rol = PersonasRolesUsuario.where(:usuario_id => current_user).pluck(:role_id)
  end
  def lista_roles
    @lista_roles = Role.all
  end
end
