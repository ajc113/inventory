# frozen_string_literal: true

class SalesController < ApplicationController
  before_action :set_sale, only: %i[destroy]
  before_action :set_location_flavors, except: %i[destroy]

  def index
    @system_configuration = SystemConfiguration.first
    @pagy, @sales = pagy(@location.sales.load_associations.order_by_date.order_by_flavor_name)
  end

  def new
    @sale = Sale.new
  end

  def create
    result = CreateSaleService.call(params, @location)
    @errors = result.meta[:message] unless result.valid?

    if result.valid?
      redirect_back(fallback_location: root_path, notice: result.meta[:message])
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @sale.destroy
      redirect_to sales_path, notice: "Sales record successfully destroyed"
    else
      redirect_to sales_path, alert: @sale.errors.full_message
    end
  end

  private

  def set_location_flavors
    @location = Location.find(params[:location_id])

    @flavors = @location.flavors.active.includes(:location_flavors)
  end

  def set_sale
    @sale = Sale.find(params[:id])
  end
end
