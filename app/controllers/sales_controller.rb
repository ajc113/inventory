# frozen_string_literal: true

class SalesController < ApplicationController
  before_action :set_location

  def new
    @sale = Sale.new
    @flavors = @location.flavors
  end

  def create
    result = CreateSaleService.call(params, @location)

    if result.valid?
      redirect_back(fallback_location: root_path, notice: result.meta[:message])
    else
      redirect_back(fallback_location: root_path, notice: result.meta[:message])
    end
  end

  private

  def set_location
    @location = Location.find(params[:location_id])
  end
end
