# frozen_string_literal: true

class Production < ApplicationRecord
  validates :quantity, presence: true

  belongs_to :flavor
  belongs_to :location
end
