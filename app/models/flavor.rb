# frozen_string_literal: true

class Flavor < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :archived, inclusion: { in: [true, false] }
  validates :quantity, :inventory, numericality: { only_integer: true }

  has_many :location_flavors, dependent: :destroy
  has_many :locations, through: :location_flavors

  default_scope -> { where(archived: true) }
end
