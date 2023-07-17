# frozen_string_literal: true

class Flavor < ApplicationRecord
  STOCK_STATUSES = {
    no: 'no',
    yes: 'yes'
  }.freeze

  enum :instock, STOCK_STATUSES, default: STOCK_STATUSES[:yes]

  validates :name, presence: true, uniqueness: true
  validates :archived, inclusion: { in: [true, false] }
  validates :quantity, :inventory, numericality: { only_integer: true }

  has_many :location_flavors
  has_many :locations, through: :location_flavors
end
