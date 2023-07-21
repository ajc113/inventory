# frozen_string_literal: true

class LocationFlavor < ApplicationRecord
  validates :quantity, :inventory, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :flavor
  belongs_to :location

  validates_uniqueness_of :flavor_id, scope: :location_id
end
