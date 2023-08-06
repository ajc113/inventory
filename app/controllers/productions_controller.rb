# frozen_string_literal: true

class ProductionsController < ApplicationController
  before_action :set_production, only: %i[destroy]
  before_action :set_location_flavors, except: %i[destroy]

  def index
    @system_configuration = SystemConfiguration.first
    @pagy, @productions = pagy(@location.productions.load_associations.order_by_date.order_by_flavor_name)
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

  def destroy
    if @production.destroy
      redirect_to productions_path, notice: "Productions record successfully destroyed"
    else
      redirect_to productions_path, alert: @production.errors.full_message
    end
  end

  private

  def set_location_flavors
    @location = Location.find(params[:location_id])

    @flavors = @location.flavors.includes(:location_flavors)
  end

  def set_production
    @production = Production.find(params[:id])
  end
end
