class Description < ActiveRecord::Base
  attr_accessible :param_val_descrip, :param_val_unit
  has_many :parameters_descriptions, :dependent => :delete_all
  has_many :parameters, :through => :parameters_descriptions

  has_many :constructions_parameters
end