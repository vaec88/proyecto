class ConstructionsChannel < ActiveRecord::Base
  attr_accessible :construction_id, :channel_id
  belongs_to :construction
  belongs_to :channel
end