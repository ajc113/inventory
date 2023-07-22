# frozen_string_literal: true

class Store < Location
  has_many :sales, dependent: :destroy, foreign_key: 'location_id'
end
