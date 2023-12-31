class LocationsController < ApplicationController
  before_action :set_location, only: %i[ show edit update destroy ]

  def index
    @pagy, @locations = pagy(Location.all)
  end

  def show; end

  def new
    @location = Location.new
  end

  def edit; end

  def create
    @location = Location.new(location_params)

    if @location.save
      redirect_to location_path(@location), notice: "Location was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @location.update(location_params)
      redirect_to location_path(@location), notice: "Location was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @location.destroy
      redirect_to locations_path, notice: "Location was successfully destroyed."
    else
      redirect_to locations_path, alert: @location.errors.full_message
    end
  end

  private
    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:name, :type, flavor_ids: [])
    end
end
