class Role < ActiveRecord::Base
  attr_accessible :rol_nombre
  #has_and_belongs_to_many :personas, :join_table => :personas_roles_usuarios
  #has_and_belongs_to_many :usuarios, :join_table => :personas_roles_usuarios

  has_many :personas_roles_usuarios#, :dependent => :delete_all
  has_many :personas, :through => :personas_roles_usuarios

  has_many :personas_roles_usuarios#, :dependent => :delete_all
  has_many :usuarios, :through => :personas_roles_usuarios

  has_many :personas_constructions_roles#, :dependent => :delete_all
  has_many :personas, :through => :personas_constructions_roles

  has_many :personas_constructions_roles#, :dependent => :delete_all
  has_many :constructions, :through => :personas_constructions_roles
end
