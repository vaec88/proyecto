class Province < ActiveRecord::Base
  attr_accessible :prov_nombre
  has_many :cantons, :dependent => :destroy
  def self.prov_id(id)
    province = find_by_id(id)
    if province
      province
    else
      nil
    end
  end
end
