# frozen_string_literal: true

class Sale < ApplicationRecord
  validates :quantity, presence: true

  belongs_to :flavor
  belongs_to :location

  def self.locations_graph_data
    joins(:location)
      .where('sales.created_at >= ?', 30.days.ago)
      .group('locations.name')
      .group_by_week(:created_at)
      .sum(:quantity)
  end
end
