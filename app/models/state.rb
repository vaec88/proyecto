class State < ActiveRecord::Base
  attr_accessible :met_val_descrip, :met_val_unit, :rebate_id
  belongs_to :rebate

  has_many :constructions_states#, :dependent => :delete_all
  has_many :constructions, :through => :constructions_states

  #has_and_belongs_to_many :constructions, :join_table => :constructions_states
end
