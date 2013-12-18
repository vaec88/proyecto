class Price < ActiveRecord::Base
  attr_accessible :aval_descrip
  has_many :constructions_prices#, :dependent => :delete_all
  has_many :constructions, :through => :constructions_prices

  #has_many :areas, :class_name=>"Area"#, :foreign_key => "price_id"#, :dependent => :delete_all
  #has_many :constructions, :through => :areas
end
