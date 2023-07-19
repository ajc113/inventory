class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def system_configuration
    @system_configuration ||= SystemConfiguration.first
  end
end
