class PersonasRolesUsuario < ActiveRecord::Base
  attr_accessible :persona_id, :role_id, :usuario_id
  belongs_to :persona
  belongs_to :role
  belongs_to :usuario
end
