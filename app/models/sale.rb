# frozen_string_literal: true

class Sale < ApplicationRecord
  validates :quantity, presence: true

  belongs_to :flavor
  belongs_to :location
end
