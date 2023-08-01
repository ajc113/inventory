# frozen_string_literal: true

class Production < ApplicationRecord
  include Sortable

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :flavor
  belongs_to :location

  def self.load_associations
    includes(:flavor, :location)
  end
end
