class Amount < ActiveRecord::Base
  attr_accessible :amo_cantidad, :amo_mes, :amo_anio, :amo_fecha
  belongs_to :usuario

  def self.estados(user_id)
#    if Time.zone.now.month == 1
#      @mes_anterior = 12
#    else
#      @mes_anterior = Time.zone.now.month - 1
#    end
#    ultima_cuota = Amount.where(:usuario_id => user_id).last
#    if ultima_cuota.amo_mes < @mes_anterior
#      Usuario.find(user_id).update_attributes(usu_estado: 'I')
#    else
#      Usuario.find(user_id).update_attributes(usu_estado: 'A')
#    end

    ultima_cuota = Amount.where(:usuario_id => user_id).last
    if ultima_cuota.amo_anio < Time.zone.now.year
      @mes_anterior = 13
      if ultima_cuota.amo_mes == 12 and Time.zone.now.month == 1 and (Time.zone.now.year - ultima_cuota.amo_anio) == 1
        @mes_anterior = 12
      end
    else
      @mes_anterior = Time.zone.now.month - 1
    end

    if ultima_cuota.amo_mes < @mes_anterior #or ultima_cuota.amo_anio < Time.zone.now.year
      Usuario.find(user_id).update_attributes(usu_estado: 'I')
    else
      Usuario.find(user_id).update_attributes(usu_estado: 'A')
    end
  end
end
