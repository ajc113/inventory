# frozen_string_literal: true

class CreateSaleService < ApplicationService
  attr_reader :params, :location

  def initialize(params, location)
    @params = params
    @location = location
  end

  def call
    errors = []
    location_flavors = LocationFlavor.where(flavor_id: location.flavors.ids, location:)

    ActiveRecord::Base.transaction do
      location_flavors.each do |location_flavor|
        flavor_id = location_flavor.flavor_id
        sales_flavor_quantity = quantity_params["#{flavor_id}_quantity"].to_i

        calculated_inventory = location_flavor.inventory - sales_flavor_quantity
        location_flavor.inventory = calculated_inventory

        create_sale_record(flavor_id, sales_flavor_quantity)
      end

      location_flavors.each(&:save!)
    rescue StandardError => exception
      errors << exception
      raise ActiveRecord::Rollback
    end

    if errors.empty?
      ServiceResponse.new(meta: { message: "Sales records saved successfully." })
    else
      ServiceResponse.new(status: 422, meta: { message: "Unable to save sales data! #{errors.join(',')}"})
    end
  end

  private

  def quantity_params
    params.select { |key, value| key.end_with?("_quantity") }
  end

  def create_sale_record(flavor_id, quantity)
    Sale.create!(location:, flavor_id:, quantity:)
  end
end
