class Channel < ActiveRecord::Base
  attr_accessible :capt_nombre
  #has_many :constructions#, :dependent => :destroy
  has_many :constructions_channels#, :dependent => :delete_all
  has_many :constructions, :through => :constructions_channels
end
