# frozen_string_literal: true

class Location < ApplicationRecord
  validates :name, :type, presence: true

  enum type: { Inventory: 'Inventory', Store: 'Store' }.freeze

  has_many :location_flavors, dependent: :destroy
  has_many :flavors, through: :location_flavors
end
