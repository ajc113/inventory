class Flavor < ApplicationRecord
  # Associations
  belongs_to :location
  
	  # Add the location_id attribute
  attribute :location_id, :integer

end
