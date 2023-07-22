# frozen_string_literal: true

class Inventory < Location
  has_many :productions, dependent: :destroy, foreign_key: 'location_id'
end
