class Operation < ActiveRecord::Base
  attr_accessible :oper_nombre
  has_many :constructions#, :dependent => :destroy
end
