class Flavor < ApplicationRecord
has_many :location_flavors

validates :name, uniqueness: true

end
