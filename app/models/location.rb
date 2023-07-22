# frozen_string_literal: true

class Location < ApplicationRecord
  validates :name, presence: true

  has_many :sales, dependent: :destroy
  has_many :location_flavors, dependent: :destroy
  has_many :flavors, through: :location_flavors

  def self.stores
    where(inventory: false)
  end

  def self.inventories
    where(inventory: true)
  end
end
