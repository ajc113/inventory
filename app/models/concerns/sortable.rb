module Sortable
  extend ActiveSupport::Concern

  included do
    def self.order_by_flavor_name
      order('flavors.name ASC')
    end
  end
end
