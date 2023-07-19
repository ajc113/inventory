# frozen_string_literal: true

class SystemConfiguration < ApplicationRecord
  PERMITTED_ATTRS = %i[
    alerting_quantity
  ].freeze

  ATTRS = PERMITTED_ATTRS

  validate :must_be_singleton, on: :create

  class << self
    ATTRS.each do |attr_name|
      define_method(attr_name) do
        singleton.send(attr_name)
      end
    end

    def singleton
      record = instance
      record.save! if record.new_record?
      record
    end

    def instance
      first_or_initialize
    end
  end

  private

  def must_be_singleton
    errors.add(:base, :must_be_singleton) if SystemConfiguration.any?
  end
end