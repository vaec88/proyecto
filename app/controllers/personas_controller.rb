class PersonasController < ApplicationController
  #ESTE CONTROLADOR SE UTILIZA SOLO PARA LISTAR, CREAR, EDITAR, ELIMINAR DEMANDANTES
  def index
    demandante = Role.find_by_rol_nombre("Demandante")
    @demandantes = Persona.joins(:usuarios).where(:personas_roles_usuarios => {:role_id => demandante.id, :usuario_id => current_user.id})
  end
  
  def new
    @demandante = Persona.new
    @inmueble = Construction.find(params[:construction_id])
    @captaciones = Channel.find(:all)
  end

  def edit
    
  end

  def create
    @inmueble = Construction.find(params[:construction_id])
    @role = Role.find_by_rol_nombre("Demandante")
    exito = "no"
    @person = Persona.new(params[:persona])
    if params[:demand_existe] == "yes"
      demandante = Persona.find_by_pers_cedula(@person.pers_cedula)
      #if demandante.update_attributes(pers_apellido: params[:pers_apellido], pers_nombre: params[:pers_nombre], pers_direccion: params[:pers_direccion], pers_telefono1: params[:pers_telefono1], pers_telefono2: params[:pers_telefono2], pers_email: params[:pers_email])
      if demandante.update_attributes(params[:persona])
        PersonasConstructionsRole.create(persona_id: demandante.id, construction_id: @inmueble.id, role_id: @role.id) #ASIGNAR UN DEMANDANTE A UN INMUEBLE
        exito = "yes"
      else
        redirect_to new_person_path(:construction_id => @inmueble.id), :notice => "Verificar datos"
      end
    else    
      
      if @person.save
        PersonasConstructionsRole.create(persona_id: @person.id, construction_id: @inmueble.id, role_id: @role.id) #ASIGNAR UN DEMANDANTE A UN INMUEBLE
        PersonasRolesUsuario.create(persona_id: @person.id, role_id: @role.id, usuario_id: current_user.id) #ASIGNAR UN DEMANDANTE A UN CORREDOR
        exito = "yes"
      else
        redirect_to new_person_path(:construction_id => @inmueble.id), :notice => "Verificar datos"
      end
    end

    if exito == "yes"
      @inmueble.update_attributes(inm_estado: 'P')
      params[:channel_ids].each do |ci|
        ConstructionsChannel.create(construction_id: @inmueble.id, channel_id: ci)
      end
      redirect_to index_construction_path, :notice => "Registrado"
    end

    #CODIGO ORIGINAL DESDE AQUI
#    if @person.save
#      @inmueble.update_attributes(inm_estado: 'P')
#      PersonasConstructionsRole.create(persona_id: @person.id, construction_id: @inmueble.id, role_id: @role.id) ASIGNAR UN DEMANDANTE A UN INMUEBLE
#      PersonasRolesUsuario.create(persona_id: @person.id, role_id: @role.id, usuario_id: current_user.id) ASIGNAR UN DEMANDANTE A UN CORREDOR
#      params[:channel_ids].each do |ci|
#        ConstructionsChannel.create(construction_id: @inmueble.id, channel_id: ci)
#      end
#      redirect_to index_construction_path, :notice => "Registrado"
#    else
#      redirect_to new_person_path(:construction_id => @inmueble.id), :notice => "Verificar datos"
#    end
    #HASTA AQUI
  end

  def update_demandante
    if Persona.where(:pers_cedula => params[:numero_cedula]).exists?
      @demandante = Persona.find_by_pers_cedula(params[:numero_cedula])
      @existe = "yes"
    else
      @demandante = nil
      @existe = "no"
    end
  end
  
  def lista
    #desde aqui
    #@det_pers_id = PersonasRolesUsuario.where(:usuario_id => current_user).pluck(:persona_id)
    #@rol = Role.where(:id => current_rol)
    #@lista_personas = Persona.where(:id => @det_pers_id)
    #hasta aqui es el cogigo original sin relacionar
    
    #@lista_personas = PersonasRolesUsuario.where(:usuario_id => current_user).joins(:persona)
    #@personas = Persona.find(params[:id])
    #@lista_personas = Persona.joins(:usuarios => :roles).where(:usuarios => {:id => current_user}, :roles => {:id => current_user.roles})
    @lista_personas = Persona.joins(:usuarios).where(:personas_roles_usuarios => {:usuario_id => current_user, :role_id => ['1','2']}).first
    @role = Role.joins(:usuarios).where(:personas_roles_usuarios => {:usuario_id => current_user, :role_id => ['1','2']}).first
    #@lista_personas = Usuario.joins(:personas).where(:id=>current_user)
    #@lista_personas = Persona.joins(:usuarios).where(:id=>)
    #@rol = Role.joins(:usuarios).where(:usuario_id=>current_user)
  end
end
