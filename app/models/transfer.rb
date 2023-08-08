# frozen_string_literal: true

class Transfer < ApplicationRecord
  include Sortable

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :flavor
  belongs_to :to_location, class_name: "Location", foreign_key: 'to_location_id'
  belongs_to :from_location, class_name: "Location", foreign_key: 'from_location_id'

  def self.load_associations
    includes(:flavor, :to_location, :from_location)
  end
end
