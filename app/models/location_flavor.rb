class LocationFlavor < ApplicationRecord
belongs_to :flavor
belongs_to :location
validates :inventory, presence: true, numericality: { greater_than_or_equal_to: 0 }
validates :flavor_id, uniqueness: { scope: :location_id }
end
