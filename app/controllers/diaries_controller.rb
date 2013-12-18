class DiariesController < ApplicationController
  def index
    @usuario = Usuario.find(params[:usuario_id])
    @actividades = Diary.where(:usuario_id => @usuario.id)
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    
    if @date.strftime("%B") == "January"
      @month = "Enero"
    end
    if @date.strftime("%B") == "February"
      @month = "Febrero"
    end
    if @date.strftime("%B") == "March"
      @month = "Marzo"
    end
    if @date.strftime("%B") == "April"
      @month = "Abril"
    end
    if @date.strftime("%B") == "May"
      @month = "Mayo"
    end
    if @date.strftime("%B") == "June"
      @month = "Junio"
    end
    if @date.strftime("%B") == "July"
      @month = "Julio"
    end
    if @date.strftime("%B") == "August"
      @month = "Agosto"
    end
    if @date.strftime("%B") == "September"
      @month = "Septiembre"
    end
    if @date.strftime("%B") == "October"
      @month = "Octubre"
    end
    if @date.strftime("%B") == "November"
      @month = "Noviembre"
    end
    if @date.strftime("%B") == "December"
      @month = "Diciembre"
    end
    #render :layout => false
  end

  def new
    @actividad = Diary.new
    @usuario = Usuario.find(params[:usuario_id])
    @fecha = params[:fecha_actual]
    @actividades = Diary.where(:usuario_id => @usuario.id, :age_fecha=>@fecha)
  end

  def create
    @actividad = Diary.new(params[:diary])
    @actividad.usuario_id = params[:usuario_id]
    if @actividad.save
      redirect_to index_diary_path(:usuario_id => @actividad.usuario_id), :notice => "Registro guardado con Exito"
    else
      redirect_to new_diary_path, :notice => "Verificar datos"
    end
  end

  def edit
    @actividad = Diary.find(params[:id])
  end

  def update
    @actividad = Diary.find(params[:id])
    @actividad.update_attributes(params[:diary])
    redirect_to index_diary_path(:usuario_id => @actividad.usuario_id), :notice => "Registro actualizado con Exito"
  end

  def destroy
    @actividad = Diary.find(params[:id])
    @actividad.destroy
    redirect_to index_diary_path(:usuario_id => @actividad.usuario_id)
  end
end
