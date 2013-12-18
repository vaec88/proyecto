class Property < ActiveRecord::Base
  attr_accessible :propd_nombre
  has_many :constructions#, :dependent => :destroy
end
