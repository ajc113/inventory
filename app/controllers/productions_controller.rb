# frozen_string_literal: true

class ProductionsController < ApplicationController
  before_action :set_location_flavors

  def index
    @productions = @location.productions.order_by_date
  end

  def new; end

  def create
    result = ProductionService.call(params, @location)
    @errors = result.meta[:message] unless result.valid?

    if result.valid?
      redirect_back(fallback_location: root_path, notice: result.meta[:message])
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_location_flavors
    @location = Location.find(params[:location_id])

    @flavors = @location.flavors.includes(:location_flavors)
  end
end
