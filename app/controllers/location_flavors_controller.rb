class LocationFlavorsController < ApplicationController

class LocationFlavorsController < ApplicationController
  before_action :set_location_flavor, only: [:edit, :update, :destroy]

  # ...

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
    params.require(:location_flavor).permit(:flavor_id, :location_id, :quantity)
  end
end




    
  end

  # DELETE /flavors/1 or /flavors/1.json
  def destroy
    @flavor.destroy

    respond_to do |format|
      format.html { redirect_to flavors_url, notice: "Flavor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flavor
      @flavor = Flavor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def flavor_params
      params.require(:flavor).permit(:name, :instock, :quantity, :location_id, :inventory)
    end


end



