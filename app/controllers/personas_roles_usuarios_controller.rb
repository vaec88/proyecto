class PersonasRolesUsuariosController < ApplicationController
  def nombres
    @list_nombre = PersonasRolesUsuario.find(:all)
  end
end
