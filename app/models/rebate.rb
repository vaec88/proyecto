class Rebate < ActiveRecord::Base
  attr_accessible :met_nombre, :met_nivel
  has_many :states, :dependent => :destroy
end
