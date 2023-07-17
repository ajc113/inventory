# frozen_string_literal: true

class Location < ApplicationRecord
  validates :name, presence: true

  has_many :location_flavors
  has_many :flavors, through: :location_flavors
end
