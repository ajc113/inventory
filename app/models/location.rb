class Location < ApplicationRecord
has_many :flavors, dependent: :nullify
end
