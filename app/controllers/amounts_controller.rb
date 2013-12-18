class AmountsController < ApplicationController
  def index
    @cuotas = Amount.where(:usuario_id => params[:usuario_id])
    @usuario = Usuario.find(params[:usuario_id])
    @cuota = Amount.new
    @mes = ""
  end

  def new
    @cuota = Amount.new
    @usuario = Usuario.find(params[:usuario_id])
  end

  def create
    @cuota = Amount.new(params[:amount])
    id = params[:usuario_id]
    @cuota.usuario_id = id
    if @cuota.save
      ultima_cuota = Amount.where(:usuario_id => id).last
      #Time.zone.now.month == 1
      if ultima_cuota.amo_anio < Time.zone.now.year
        @mes_anterior = 13
        if ultima_cuota.amo_mes == 12 and Time.zone.now.month == 1 and (Time.zone.now.year - ultima_cuota.amo_anio) == 1
          @mes_anterior = 12
        end
      else
        @mes_anterior = Time.zone.now.month - 1
      end
      
      if ultima_cuota.amo_mes < @mes_anterior #or ultima_cuota.amo_anio < Time.zone.now.year
        Usuario.find(id).update_attributes(usu_estado: 'I')
      else
        Usuario.find(id).update_attributes(usu_estado: 'A')
      end

      redirect_to index_amount_path(:usuario_id => id), :notice => "Registro de cuota guardado con exito"
    else
      redirect_to new_amount_path, :notice => "Verificar datos"
    end
  end

  def destroy
    @cuota = Amount.find(params[:id])
    @cuota.destroy
    redirect_to index_amount_path(:usuario_id => @cuota.usuario_id)
  end

  def edit
   @cuota = Amount.find(params[:id])
  end

  def update
    @cuota = Amount.find(params[:id])
    @cuota.update_attributes(params[:amount])
    redirect_to index_amount_path(:usuario_id => @cuota.usuario_id)
  end
end