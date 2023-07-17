# frozen_string_literal: true

class LocationFlavor < ApplicationRecord
  validates :quantity, :inventory, numericality: { only_integer: true }

  belongs_to :flavor
  belongs_to :location

  validates_uniqueness_of :flavor_id, scope: :location_id
end
