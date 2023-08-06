# frozen_string_literal: true

class FlavorsController < ApplicationController
  before_action :set_flavor, only: %i[edit update show destroy]

  def index
    @pagy, @flavors = pagy(Flavor.includes(:locations).order_by_name)
  end

  def new
    @flavor = Flavor.new
  end

  def create
    @flavor = Flavor.new(create_flavor_params)

    if @flavor.save
      redirect_to flavors_path, notice: "Flavor created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @flavor.update(flavor_params)
      redirect_to flavors_path, notice: "Flavor updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show; end

  def destroy
    if @flavor.destroy
      redirect_to flavors_path, notice: "Flavor was successfully destroyed."
    else
      redirect_to flavors_path, alert: @flavor.errors.full_message
    end
  end

  private

  def create_flavor_params
    location_ids = Location.all.pluck(:id).compact

    flavor_params.merge(location_ids: location_ids)
  end

  def flavor_params
    params.require(:flavor).permit(:name, :archived, :price, :unit_cost)
  end

  def set_flavor
    @flavor = Flavor.find(params[:id])
  end
end
