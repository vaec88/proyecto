class Persona < ActiveRecord::Base
  attr_accessible :pers_cedula, :pers_apellido, :pers_nombre, :pers_direccion, :pers_telefono1, :pers_telefono2, :pers_email, :pers_estado

  #has_and_belongs_to_many :roles, :join_table => :personas_roles_usuarios
  #has_and_belongs_to_many :usuarios, :join_table => :personas_roles_usuarios

  has_many :personas_roles_usuarios#, :dependent => :delete_all
  has_many :roles, :through => :personas_roles_usuarios

  has_many :personas_roles_usuarios#, :dependent => :delete_all
  has_many :usuarios, :through => :personas_roles_usuarios

  has_many :personas_constructions_roles#, :dependent => :delete_all
  has_many :constructions, :through => :personas_constructions_roles

  has_many :personas_constructions_roles#, :dependent => :delete_all
  has_many :roles, :through => :personas_constructions_roles
#  def self.consulta(codigo_usuario)
#    lista_personas = find_by_usuario_id(codigo_usuario)
#    lista_personas.each do |persona|
#      puts "#{persona.pers_cedula}: #{persona.pers_apellido}: #{persona.pers_nombre}"
#    end
#  end

end