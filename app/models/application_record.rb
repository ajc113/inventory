class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.order_by_date(direction: :desc)
    order(created_at: direction)
  end

  def system_configuration
    @system_configuration ||= SystemConfiguration.first
  end
end
