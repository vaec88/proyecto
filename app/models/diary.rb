class Diary < ActiveRecord::Base
  attr_accessible :age_actividad, :age_fecha, :age_hora, :age_direccion, :usuario_id
  belongs_to :usuario
end
