# frozen_string_literal: true

class TransfersController < ApplicationController
  before_action :set_transfer, only: %i[destroy]
  before_action :set_flavors_locations, only: %i[new create]

  def index
    @transfers = Transfer.load_associations.order_by_date.order_by_flavor_name
  end

  def new
    @transfer = Transfer.new
  end

  def create
    result = TransferService.call(params)

    @transfer = result.data
    @errors = result.meta[:message] unless result.valid?

    if result.valid?
      redirect_to transfers_path, notice: result.meta[:message]
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @transfer.destroy
      redirect_to transfers_path, notice: "transfers record successfully destroyed"
    else
      redirect_to transfers_path, alert: @transfer.errors.full_message
    end
  end

  private

  def set_flavors_locations
    @to_location = Location.find(params[:to_location_id])
    @from_location = Location.find(params[:from_location_id])

    message = 'Transfer can only take place between different locations'
    return redirect_back(fallback_location: transfers_path, alert: message) if @from_location.id == @to_location.id

    @flavors = @from_location.flavors
  end

  def set_transfer
    @transfer = Transfer.find(params[:id])
  end
end
