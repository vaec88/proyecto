class Meeting < ActiveRecord::Base
  attr_accessible :reu_actores, :reu_detalle, :reu_fecha_hora, :reu_estado, :construction_id
  belongs_to :construction
end
