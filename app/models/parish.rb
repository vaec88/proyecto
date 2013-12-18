class Parish < ActiveRecord::Base
  attr_accessible :parr_nombre, :canton_id
  belongs_to :canton
  has_many :constructions#, :dependent => :destroy
end
