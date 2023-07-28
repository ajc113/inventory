# frozen_string_literal: true

class TransfersController < ApplicationController
  before_action :set_from_location
  before_action :set_to_location, only: %i[new create]

  def index
    @transfers = @from_location.transfers.load_associations.order_by_date
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

  private

  def set_from_location
    @from_location = Location.find(params[:from_location_id])

    @flavors = @from_location.flavors
  end

  def set_to_location
    @to_location = Location.find(params[:to_location_id])
  end
end
