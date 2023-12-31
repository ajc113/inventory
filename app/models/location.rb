class Location < ApplicationRecord
  validates :name, :type, presence: true

  enum type: { Inventory: 'Inventory', Store: 'Store' }.freeze

  has_many :location_flavors, dependent: :destroy
  has_many :flavors, through: :location_flavors

  scope :alphabetical, -> { order(name: :asc) }

  accepts_nested_attributes_for :location_flavors, reject_if: :all_blank

  after_create :associate_flavors

  private

  def associate_flavors
    Flavor.find_each do |flavor|
      location_flavors.create!(flavor:)
    end
  end
end
