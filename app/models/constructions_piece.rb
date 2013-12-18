class ConstructionsPiece < ActiveRecord::Base
  self.primary_key = "id"
  attr_accessible :construction_id, :piece_id, :det_numero, :det_descrip
  belongs_to :construction
  belongs_to :piece
end
