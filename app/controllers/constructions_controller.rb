class ConstructionsController < ApplicationController
  def index
    rol = Role.joins(:usuarios).where(:personas_roles_usuarios => {:usuario_id => current_user, :role_id => ['1','2']}).first
    persona = Persona.joins(:usuarios).where(:personas_roles_usuarios => {:usuario_id => current_user, :role_id => ['2']}).first
    if rol.id == 1
      @inmueble = Construction.find(:all)
      @inmueble = Construction.where(:id => @inmueble).paginate(:page => params[:page], :per_page => 3)
      @json = @inmueble.all.to_gmaps4rails
    else
      @inmueble = Construction.joins(:personas).where(:personas_constructions_roles => {:persona_id => persona.id, :role_id => ['2']}).paginate(:page => params[:page], :per_page => 3)
      @json = @inmueble.all.to_gmaps4rails
    end
    
    @rol_demandante = Role.find_by_rol_nombre("Demandante")
    #PARA REALIZAR LA BUSQUEDA DE LOS INMUEBLES
    @operacion = Operation.find(:all)
    @propiedad = Property.find(:all)
    @provincia = Province.find(:all)
    @partes = Piece.find(:all)
    @canton = []
    @parroquia = []
  end

  def search
    @operacion = Operation.find(:all)
    @propiedad = Property.find(:all)
    @provincia = Province.find(:all)
    @partes = Piece.find(:all)
    @canton = []
    @parroquia = []

    
    #partes = Piece.find(:all)
    persona = Persona.joins(:usuarios).where(:personas_roles_usuarios => {:usuario_id => current_user, :role_id => ['2']}).first
    if persona.nil?
      const_ids = Construction.find(:all)
      #const_ids = Construction.where(:inm_estado => "A")
      @search = Construction.where(:id => const_ids, :inm_estado => ["A","P"])
    else
      @search = Construction.joins(:personas).where(:personas_constructions_roles => {:persona_id => persona.id, :role_id => ['2']})
    end

    
    @search = @search.where('operation_id LIKE ?', params[:operation_id_search]) unless params[:operation_id_search].blank?
    @search = @search.where('property_id LIKE ?', params[:property_id_search]) unless params[:property_id_search].blank?
    #@search = @search.joins(:parish => {:canton => :province}).where('provinces.id LIKE ?', params[:province_id_search]) unless params[:province_id_search].blank?
    @search = @search.joins(:parish => {:canton => :province}).where(:provinces =>{:id => params[:province_id_search]}) unless params[:province_id_search].blank?
    #@search = @search.joins(:parish => :canton).where('cantons.id LIKE ?', params[:canton_id_search]) unless params[:canton_id_search].blank?
    @search = @search.joins(:parish => :canton).where(:cantons => {:id => params[:canton_id_search]}) unless params[:canton_id_search].blank?
    @search = @search.where('inm_val_merc >= ?', params[:precio_inmueble_1]) unless params[:precio_inmueble_1].blank?
    @search = @search.where('inm_val_merc <= ?', params[:precio_inmueble_2]) unless params[:precio_inmueble_2].blank?
#    partes.each do |p|
#      @search = @search.joins(:pieces).where('constructions_pieces.det_numero LIKE ?', params["piece_id_search_" + "#{p.id}"]) unless params["piece_id_search_" + "#{p.id}"].blank?
#    end

    #PARA CAPTURAR LOS IDS DE LAS PARTES QUE SE UTILIZA COMO PARAMETROS DE BUSQUEDA
    @piece_ids_current = []
    count = 0
    params[:piece_ids].each do |pi|
      if params["piece_id_search_" + "#{pi}"].blank?
        ""
      else
        @piece_ids_current[count] = pi
        count+=1
      end
    end
    
    #@search = @search.joins(:pieces).where("pieces.id in (?)",['2'||'3'])
    #@search = @search.joins(:pieces).where("pieces.id in (?)",@piece_ids_current.to_sentence(words_connector: '||'))

    @search = @search.joins(:pieces).uniq unless @search.joins(:pieces)
    const_piece_found =[]
    contador_inm = 0
    @search.each do |sear|
      contador_partes = 0
      @piece_ids_current.each do |pic|
        if ConstructionsPiece.find_by_construction_id_and_piece_id_and_det_numero(sear.id, pic, params["piece_id_search_" + "#{pic}"]).nil?
          
        else
          contador_partes+=1
        end
      end
      if contador_partes == @piece_ids_current.count()
        const_piece_found[contador_inm] = sear.id
        contador_inm+=1
      end
    end
    @search = @search.where(:id => const_piece_found).uniq
    
    @search = @search.paginate(:page => params[:page], :per_page => 3)
    @json = @search.all.to_gmaps4rails

    @rol_demandante = Role.find_by_rol_nombre("Demandante")
  end

  def new
    @inmueble = Construction.new
    @persona = Persona.new
    @operacion = Operation.find(:all)
    @propiedad = Property.find(:all)
    @provincia = Province.find(:all)
    @canton = []
    @parroquia = []

    @partes = Piece.find(:all)
  end

  def update_cantons
    provincia = Province.find(params[:province_id])
    @canton = provincia.cantons.map{|c| [c.cant_nombre, c.id]}.insert(0, "Seleccione un Canton")
    @parroquia =[].insert(0,"Seleccione una Parroquia")
#    @canton = Canton.find(:all,:conditions=>{:province_id=>params[:province_id].to_i})
  end

  def update_parishes
    canton = Canton.find(params[:canton_id])
    @parroquia = canton.parishes.map{|p| [p.parr_nombre, p.id]}.insert(0, "Seleccione una Parroquia")
  end

  def update_propietario
    if Persona.where(:pers_cedula => params[:numero_cedula]).exists?
      @propietario = Persona.find_by_pers_cedula(params[:numero_cedula])
      @existe = "yes"
    else
      @propietario = nil
      @existe = "no"
    end
  end

  def create
    @inmueble = Construction.new(params[:construction])
    @inmueble.inm_estado = "A"
    @person = Persona.new(params[:persona])
    @role = Role.find_by_rol_nombre("Propietario")

    rol = Role.joins(:usuarios).where(:personas_roles_usuarios => {:usuario_id => current_user, :role_id => ['1','2']}).first #ROL DEL USUARIO ACTUAL
    persona = Persona.joins(:usuarios).where(:personas_roles_usuarios => {:usuario_id => current_user, :role_id => ['2']}).first #DATOS DEL USUARIO ACTUAL

    if params[:propiet_existe] == "yes"
      propietario = Persona.find_by_pers_cedula(@person.pers_cedula)
      if propietario.update_attributes(params[:persona]) and @inmueble.save
        PersonasConstructionsRole.create(persona_id: persona.id, construction_id: @inmueble.id, role_id: rol.id) #ASIGNAR UN CORREDOR A UN INMUEBLE
        PersonasConstructionsRole.create(persona_id: propietario.id, construction_id: @inmueble.id, role_id: @role.id) #ASIGNAR UN PROPIETARIO A UN INMUEBLE
        exito = "yes"
      else
        redirect_to new_construction_path, :notice => "Verificar datos"
      end
    else

      if @person.save and @inmueble.save
        PersonasConstructionsRole.create(persona_id: persona.id, construction_id: @inmueble.id, role_id: rol.id) #ASIGNAR UN CORREDOR A UN INMUEBLE
        PersonasConstructionsRole.create(persona_id: @person.id, construction_id: @inmueble.id, role_id: @role.id) #ASIGNAR UN PROPIETARIO A UN INMUEBLE
        PersonasRolesUsuario.create(persona_id: @person.id, role_id: @role.id, usuario_id: current_user.id) #ASIGNAR UN PROPIETARIO A UN CORREDOR
        exito = "yes"
      else
        redirect_to new_construction_path, :notice => "Verificar datos"
      end
    end

    if exito == "yes"
      params[:piece_ids].each do |pi|
        ConstructionsPiece.create(construction_id: @inmueble.id, piece_id: pi.to_i, det_numero: params["det_numero_"+"#{pi}"], det_descrip: params["det_descrip_"+"#{pi}"])
      end
      redirect_to index_construction_path, :notice => "Registrado"
    end
    


    # CODIGO ORIGINAL DESDE AQUI
#    rol = Role.joins(:usuarios).where(:personas_roles_usuarios => {:usuario_id => current_user, :role_id => ['1','2']}).first
#    persona = Persona.joins(:usuarios).where(:personas_roles_usuarios => {:usuario_id => current_user, :role_id => ['2']}).first
#    if @inmueble.save and @person.save
#      PersonasConstructionsRole.create(persona_id: persona.id, construction_id: @inmueble.id, role_id: rol.id) ASIGNAR UN CORREDOR A UN INMUEBLE
#      PersonasConstructionsRole.create(persona_id: @person.id, construction_id: @inmueble.id, role_id: @role.id) ASIGNAR UN PROPIETARIO A UN INMUEBLE
#      PersonasRolesUsuario.create(persona_id: @person.id, role_id: @role.id, usuario_id: current_user.id) ASIGNAR UN PROPIETARIO A UN CORREDOR
#      params[:piece_ids].each do |pi|
#        ConstructionsPiece.create(construction_id: @inmueble.id, piece_id: pi.to_i, det_numero: params["det_numero_"+"#{pi}"], det_descrip: params["det_descrip_"+"#{pi}"])
#      end
#      redirect_to index_construction_path, :notice => "Registrado"
#    else
#      redirect_to new_construction_path, :notice => "Verificar datos"
#    end
    #HASTA AQUI
  end

  def show
    @inmueble = Construction.find(params[:id])
    
    @rol_corredor = Role.find_by_rol_nombre("Corredor")
    @corredor = Persona.joins(:constructions).where(:personas_constructions_roles => {:construction_id => @inmueble.id, :role_id => @rol_corredor.id}).first

    @rol_propietario = Role.find_by_rol_nombre("Propietario")
    @propietario = Persona.joins(:constructions).where(:personas_constructions_roles => {:construction_id => @inmueble.id, :role_id => @rol_propietario.id}).first

    @rol_demandante = Role.find_by_rol_nombre("Demandante")
    @demandante = Persona.joins(:constructions).where(:personas_constructions_roles => {:construction_id => @inmueble.id, :role_id => @rol_demandante.id}).first
  end

  def destroy
    @inmueble = Construction.find(params[:id])
    @inmueble.destroy
    redirect_to index_construction_path
  end

  def edit
    @inmueble = Construction.find(params[:id])
    @operacion = Operation.find(:all)
    @propiedad = Property.find(:all)
    @captaciones = Channel.find(:all)
    
    @provincia = Province.find(:all)
    @cod_prov = Province.joins(:cantons => :parishes).where(:parishes => {:id => @inmueble.parish_id})
    @canton = Canton.joins(:province).where(:province_id => @cod_prov)
    @cod_cant = Canton.joins(:parishes).where(:parishes => {:id => @inmueble.parish_id})
    @parroquia = Parish.joins(:canton).where(:canton_id => @cod_cant)

    @operacion_actual = Operation.find(@inmueble.operation_id)
    @propiedad_actual = Property.find(@inmueble.property_id)
    @parroquia_actual = Parish.find(@inmueble.parish_id)
    @canton_actual = Canton.find(@parroquia_actual.canton_id)
    @provincia_actual = Province.find(@canton_actual.province_id)

    @rol_propietario = Role.find_by_rol_nombre("Propietario")
    @propietario = Persona.joins(:personas_constructions_roles).where(:personas_constructions_roles => {:construction_id => @inmueble.id, :role_id => @rol_propietario.id}).first

    @rol_demandante = Role.find_by_rol_nombre("Demandante")
    @demandante = Persona.joins(:personas_constructions_roles).where(:personas_constructions_roles => {:construction_id => @inmueble.id, :role_id => @rol_demandante.id}).first

    @partes = Piece.find(:all)
    @partes_const_actual = ConstructionsPiece.where(:construction_id => @inmueble.id)
  end

  def update
    if params[:pers_id].present?
      @propietario = Persona.find(params[:pers_id])
      @propietario.update_attributes(pers_cedula: params[:pers_cedula], pers_apellido: params[:pers_apellido], pers_nombre: params[:pers_nombre], pers_direccion: params[:pers_direccion], pers_telefono1: params[:pers_telefono1], pers_telefono2: params[:pers_telefono2], pers_email: params[:pers_email])
    end

    if params[:demand_id].present?
      @demandante = Persona.find(params[:demand_id])
      @demandante.update_attributes(pers_cedula: params[:demand_cedula], pers_apellido: params[:demand_apellido], pers_nombre: params[:demand_nombre], pers_direccion: params[:demand_direccion], pers_telefono1: params[:demand_telefono1], pers_telefono2: params[:demand_telefono2], pers_email: params[:demand_email])
      params[:construction][:channel_ids]||=[]
    end

    @inmueble = Construction.find(params[:id])
    @inmueble.update_attributes(params[:construction])

    if params[:inm_estado] == "1"
      @inmueble.update_attributes(inm_estado: "A")
      role = Role.find_by_rol_nombre("Demandante")
      demand = Persona.find(params[:demand_id])
      PersonasConstructionsRole.find_by_persona_id_and_construction_id_and_role_id(demand.id, @inmueble.id, role.id).destroy
    end
    #@propietario.update_attributes(params[:persona])
    const_piece = ConstructionsPiece.where(:construction_id => @inmueble.id)
    
    params[:piece_actuals].each do |pa|
      existe = "no"
      params[:piece_ids].each do |pis|
        if pa == pis
          existe = "si"
        end
      end
      if existe == "no"
        const_piece.find_by_piece_id(pa).destroy
      end
    end

    params[:piece_ids].each do |pi|
      if const_piece.find_by_piece_id(pi)
        const_piece.find_by_piece_id(pi).update_attributes(det_numero: params["det_numero_"+"#{pi}"], det_descrip: params["det_descrip_"+"#{pi}"])
      else
        ConstructionsPiece.create(construction_id: @inmueble.id, piece_id: pi.to_i, det_numero: params["det_numero_"+"#{pi}"], det_descrip: params["det_descrip_"+"#{pi}"])
      end
    end
    redirect_to index_construction_path
  end

  def close
    Construction.find(params[:construction_id]).update_attributes(inm_estado: "I")
    redirect_to index_construction_path
  end
end