# frozen_string_literal: true

class Transfer < ApplicationRecord
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :to_from_locations_type

  belongs_to :flavor
  belongs_to :to_location, class_name: "Location", foreign_key: 'to_location_id'
  belongs_to :from_location, class_name: "Location", foreign_key: 'from_location_id'

  private

  def to_from_locations_type
    errors.add(:base, :valid_location_type) if to_location.inventory || !from_location.inventory
  end
end
