# frozen_string_literal: true

class CreateSaleService < ApplicationService
  attr_reader :params, :location

  def initialize(params, location)
    @params = params
    @location = location
  end

  def call
    errors = []
    sales = []

    ActiveRecord::Base.transaction do
      location.flavors.each do |flavor|
        sales_flavor_quantity = quantity_params["#{flavor.id}_quantity"].to_i

        location_flavor = flavor.location_flavors.find_by(location: location)

        calculated_inventory = location_flavor.inventory - sales_flavor_quantity
        location_flavor.update!(inventory: calculated_inventory)

        sales << Sale.create!(location: location, flavor: flavor, quantity: sales_flavor_quantity)
      end
    rescue StandardError => exception
      errors << exception
      raise ActiveRecord::Rollback
    end

    if errors.empty?
      ServiceResponse.new(meta: { message: "Sales records saved successfully." })
    else
      ServiceResponse.new(status: 422, meta: { message: "Something went wrong! error while saving sales data."})
    end
  end

  private

  def quantity_params
    params.select { |key, value| key.end_with?("_quantity") }
  end
end
