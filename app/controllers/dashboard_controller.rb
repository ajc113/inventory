class DashboardController < ApplicationController
  def show
    @locations = Location.all
    @sales_locations_data = Sale.locations_graph_data
    @pagy, @flavors = pagy(Flavor.includes(:location_flavors).order_by_name)
  end
end
