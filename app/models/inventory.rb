# frozen_string_literal: true

class Inventory < Location
  has_many :transfers, dependent: :destroy, foreign_key: 'from_location_id'
  has_many :productions, dependent: :destroy, foreign_key: 'location_id'
end
