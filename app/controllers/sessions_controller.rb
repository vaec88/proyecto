class SessionsController < ApplicationController
  def new
  end
  def create
    user = Usuario.authenticate(params[:usu_username], params[:usu_password])

    rol = Role.find_by_rol_nombre("Administrador")
    
    if user #PARA SABER SI EL USUARIO Y CONTRASEÑA SON CORRECTOS

      if Usuario.joins(:roles).where(:id => user.id, :roles => {:id => rol.id}).exists? == false        
        Amount.estados(user.id)
      end
      user = Usuario.find(user.id)
      if user.usu_estado == "A"
        session[:usuario_id] = user.id
        redirect_to index_construction_path, :notice => "Conectado!"
      else
        redirect_to morosos_path, :notice => "Error!"
      end
      
      #redirect_to ingresaste_path, :notice => "Conectado!"
      #redirect_to lista_path, :notice => "Conectado!"
      
      #redirect_to sing_up_path, :notice => "Conectado!"
    else
#      flash.now.alert = "Email o clave incorrecta"
#      render "new"
      redirect_to falla_sesion_path, :notice => "Error!"
    end
  end
  def destroy
    session[:usuario_id] = nil
    redirect_to root_url, :notice => "Desconectado!"
  end
end
