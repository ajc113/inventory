# frozen_string_literal: true

class Production < ApplicationRecord
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :flavor
  belongs_to :location
end