# frozen_string_literal: true

class TransferService < ApplicationService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    errors = []

    ActiveRecord::Base.transaction do
      @transfer_record = create_transfer_record

      deduct_quantity_from_location

      add_quantity_to_location

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

  def transfer_params
    params.require(:transfer).permit(:quantity, :flavor_id, :from_location_id, :to_location_id)
  end

  def create_transfer_record
    Transfer.create!(transfer_params)
  end

  def deduct_quantity_from_location
    location_flavor = from_location.location_flavors.find_by!(flavor_id: flavor.id)

    calculated_quantity = location_flavor.inventory - transfer_params[:quantity].to_i

    location_flavor.update!(inventory: calculated_quantity)
  end

  def add_quantity_to_location
    location_flavor = to_location.location_flavors.find_by!(flavor_id: flavor.id)

    calculated_quantity = location_flavor.inventory + transfer_params[:quantity].to_i

    location_flavor.update!(inventory: calculated_quantity)
  end

  def flavor
    @flavor ||= Flavor.find(transfer_params[:flavor_id])
  end

  def from_location
    @from_location ||= Location.find(transfer_params[:from_location_id])
  end

  def to_location
    @to_location ||= Location.find(transfer_params[:to_location_id])
  end
end
