# frozen_string_literal: true

class ProductionService < ApplicationService
  attr_reader :params, :location

  def initialize(params, location)
    @params = params
    @location = location
  end

  def call
    errors = []
    location_flavors = location.location_flavors

    ActiveRecord::Base.transaction do
      location_flavors.each do |location_flavor|
        flavor_id = location_flavor.flavor_id
        flavor_quantity = quantity_params["#{flavor_id}_quantity"].to_i

        errors << invalid_quantity_error(location_flavor) if flavor_quantity.negative?

        calculated_inventory = location_flavor.inventory + flavor_quantity
        location_flavor.inventory = calculated_inventory

        create_production_record(flavor_id, flavor_quantity)
      end

      location_flavors.each(&:save!)
    rescue StandardError => exception
      raise ActiveRecord::Rollback
    end

    if errors.empty?
      ServiceResponse.new(meta: { message: "Production records saved successfully." })
    else
      ServiceResponse.new(status: 422, meta: { message: errors })
    end
  end

  private

  def quantity_params
    params.select { |key, value| key.end_with?("_quantity") }
  end

  def invalid_quantity_error(location_flavor)
    "#{location_flavor.flavor.name} quantity can't be less than zero."
  end

  def create_production_record(flavor_id, quantity)
    Production.create(location:, flavor_id:, quantity:)
  end
end
