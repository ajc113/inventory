class LocationFlavor < ApplicationRecord
  belongs_to :flavor
  belongs_to :location
end
