# frozen_string_literal: true

class Flavor < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :archived, inclusion: { in: [true, false] }
  validates :quantity, :inventory, numericality: { only_integer: true }

  has_many :location_flavors, dependent: :destroy
  has_many :locations, through: :location_flavors

  default_scope -> { where(archived: true) }

  def fetch_location_flavor(location)
    location_flavors.find do |location_flavor|
      location_flavor.location_id == location.id
    end
  end

  def location_inventory(location)
    location_flavor = fetch_location_flavor(location)

    location_flavor ? location_flavor.inventory : 0
  end

  def alerting_inventory?(location)
    location_flavor = fetch_location_flavor(location)

    location_flavor.inventory.to_i <= SystemConfiguration.first.alerting_quantity
  end
end