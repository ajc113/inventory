class LocationFlavorsController < ApplicationController
  before_action :set_location_flavor, only: [:edit, :update, :destroy]

def index
  @instock_flavors = Flavor.where(instock: 'Yes')
  @locations = Location.all
  @location_flavors = LocationFlavor.joins(:flavor, :location).where(flavors: { instock: 'Yes' })
end
  def new_increase_inventory_form
    @locations = Location.all
    @instock_flavors = Flavor.where(instock: 'Yes')
  end


  def increase_inventory
    location_flavor_changes = params[:location_flavor_changes]

    location_flavor_changes.each do |_key, flavor_changes|
      flavor_changes.each do |_key, change|
        location_id = change[:location_id]
        flavor_id = change[:flavor_id]
        inventory_change = change[:inventory_change].to_i

        location_flavor = LocationFlavor.find_by(location_id: location_id, flavor_id: flavor_id)
        next unless location_flavor

        location_flavor.inventory += inventory_change
        location_flavor.save
      end
    end

    redirect_to location_flavors_path, notice: 'Inventory updated successfully!'
  end


def decrease_inventory
  @location = Location.find(params[:location_id])
  @instock_flavors = Flavor.where(instock: 'Yes')
  @location_flavor = LocationFlavor.new
end

    def update_inventory
    @location = Location.find(params[:location_id])
    location_flavor_changes = params[:location_flavor_changes]

    location_flavor_changes.each do |flavor_id, changes|
      flavor = Flavor.find(flavor_id)
      inventory_change = changes[:inventory_change].to_i

      location_flavor = LocationFlavor.find_by(location: @location, flavor: flavor)
      if location_flavor
        location_flavor.inventory -= inventory_change
        location_flavor.save
      end
    end

    redirect_to location_flavors_inventory_levels_path, notice: 'Inventory updated successfully.'
  end




	def inventory_levels
    @instock_flavors = Flavor.where(instock: 'Yes')
    @locations = Location.all
	end

  	def new
    @location_flavor = LocationFlavor.new
    @flavors = Flavor.all
    @locations = Location.all
  	end

  	def create
    @location_flavor = LocationFlavor.new(location_flavor_params)
    if @location_flavor.save
      redirect_to @location_flavor.location, notice: 'Location flavor created successfully.'
    else
      @flavors = Flavor.all
      @locations = Location.all
      render :new
    end
  end

  def edit
    @flavors = Flavor.all
    @locations = Location.all
  end

  def update
    if @location_flavor.update(location_flavor_params)
      redirect_to @location_flavor.location, notice: 'Location flavor updated successfully.'
    else
      @flavors = Flavor.all
      @locations = Location.all
      render :edit
    end
  end

  def destroy
    location = @location_flavor.location
    @location_flavor.destroy
    redirect_to location, notice: 'Location flavor deleted successfully.'
  end

  # ...

  private

  def set_location_flavor
    @location_flavor = LocationFlavor.find(params[:id])
  end

  def location_flavor_params
    params.require(:location_flavor).permit(:flavor_id, :location_id, :inventory)
  end

  def location_flavor_inventory(flavor, location)
    location_flavor = LocationFlavor.find_by(flavor: flavor, location: location)
    location_flavor&.inventory || 0
  end
end



