class Flavor < ApplicationRecord
  # Associations
  #belongs_to :location

validates :name, uniqueness: true

end
