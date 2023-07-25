# frozen_string_literal: true

class FlavorsController < ApplicationController
  def index
    @flavors = Flavor.all.includes(:locations).order_by_name
  end

  def new
    @flavor = Flavor.new
  end

  def create
    @flavor = Flavor.new(flavor_params)

    if @flavor.save
      redirect_to flavors_path, notice: "Flavor created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def flavor_params
    location_ids = [params.dig(:flavor, :store_location_id), params.dig(:flavor, :inventory_location_id)].compact

    params.require(:flavor).permit(:name, :archived).merge(location_ids: location_ids)
  end
end
