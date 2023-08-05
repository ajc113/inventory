# frozen_string_literal: true

class Sale < ApplicationRecord
  include Sortable

  validates :quantity, presence: true

  belongs_to :flavor
  belongs_to :location

  def self.revenue_data_for_graph
    joins(:flavor).group_by_day(:created_at).sum('sales.quantity * flavors.price')
  end

  def self.load_associations
    includes(:flavor, :location)
  end
end
