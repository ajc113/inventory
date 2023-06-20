class LocationFlavorsController < ApplicationController
  before_action :set_location_flavor, only: [:edit, :update, :destroy]

 	def index
 	@instock_flavors = Flavor.where(instock: true)
	@locations = Location.all
	@location_flavors = LocationFlavor.includes(:flavor, :location)
	end

	def increase_inventory_form
	  puts "Location ID: #{params[:location_id]}"
	  @location_flavors = LocationFlavor.includes(:flavor, :location)
	  # @location = Location.find(params[:location_id])
	end

	def increase_inventory
	  location_flavor_ids = location_flavor_params[:location_flavor_ids]
		if location_flavor_ids.nil?
		  # Handle the case when location_flavor_ids is nil
		else
		  location_flavor_ids.each_with_index do |location_flavor_id, index|
		    # Process each location_flavor_id
		  end

	    location_flavor = LocationFlavor.find(location_flavor_id)
	    increase_amount = location_flavor_params[:inventory_increases][index].to_i
	    location_flavor.inventory += increase_amount
	    location_flavor.save
	  end

	  redirect_to location_flavors_path, notice: 'Inventory increased successfully.'
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



