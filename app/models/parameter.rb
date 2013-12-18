class Parameter < ActiveRecord::Base
  attr_accessible :param_descrip, :description_ids
  has_many :parameters_descriptions, :dependent => :delete_all
  has_many :descriptions, :through => :parameters_descriptions

  has_many :constructions_parameters#, :dependent => :delete_all
  has_many :constructions, :through => :constructions_parameters
end