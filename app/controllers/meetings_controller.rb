class MeetingsController < ApplicationController
  def index
    @inmueble = Construction.find(params[:construction_id])
    @reuniones = Meeting.where(:construction_id => @inmueble.id)
    @reunion = Meeting.new
  end

  def new
    @reunion = Meeting.new
    @inmueble = Construction.find(params[:construction_id])
  end

  def create
    @reunion = Meeting.new(params[:meeting])
    @reunion.reu_fecha_hora = Time.zone.now
    @reunion.construction_id = params[:construction_id]
    if @reunion.save
      redirect_to index_meeting_path(:construction_id => @reunion.construction_id), :notice => "Registro guardado con Exito"
    else
      redirect_to new_meeting_path, :notice => "Verificar datos"
    end
  end

  def edit
    @reunion = Meeting.find(params[:id])
  end

  def update
    @reunion = Meeting.find(params[:id])
    @reunion.update_attributes(params[:meeting])
    redirect_to index_meeting_path(:construction_id => @reunion.construction_id), :notice => "Registro actualizado con Exito"
  end

  def destroy
    @reunion = Meeting.find(params[:id])
    @reunion.destroy
    redirect_to index_meeting_path(:construction_id => @reunion.construction_id)
  end
end
