# frozen_string_literal: true

class TransferService < ApplicationService
  attr_reader :params, :from_location

  def initialize(params)
    @params = params
  end

  def call
    errors = []
    location_flavors = from_location.location_flavors

    ActiveRecord::Base.transaction do
      location_flavors.each do |location_flavor|
        flavor_id = location_flavor.flavor_id
        transfer_quantity = quantity_params["#{flavor_id}_quantity"].to_i

        @transfer_record = create_transfer_record(flavor_id, transfer_quantity)

        deduct_quantity_from_location(flavor_id, transfer_quantity)

        add_quantity_to_location(flavor_id, transfer_quantity)
      end
    rescue StandardError => exception
      errors << exception
      raise ActiveRecord::Rollback
    end

    if errors.empty?
      ServiceResponse.new(data: @transfer_record, meta: { message: "Transfer record saved successfully." })
    else
      ServiceResponse.new(data: @transfer_record, status: 422, meta: { message: errors })
    end
  end

  private

  def quantity_params
    params.select { |key, value| key.end_with?("_quantity") }
  end

  def create_transfer_record(flavor_id, quantity)
    Transfer.create!(quantity:, flavor_id:, to_location:, from_location:)
  end

  def deduct_quantity_from_location(flavor_id, quantity)
    location_flavor = from_location.location_flavors.find_by!(flavor_id:)

    calculated_quantity = location_flavor.inventory - quantity.to_i

    location_flavor.update!(inventory: calculated_quantity)
  end

  def add_quantity_to_location(flavor_id, quantity)
    location_flavor = to_location.location_flavors.find_by!(flavor_id:)

    calculated_quantity = location_flavor.inventory + quantity.to_i

    location_flavor.update!(inventory: calculated_quantity)
  end

  def from_location
    @from_location ||= Location.find(params[:from_location_id])
  end

  def to_location
    @to_location ||= Location.find(params[:to_location_id])
  end
end
