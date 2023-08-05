class DashboardController < ApplicationController
  def show
    @locations = Location.all
    @revenue_data_for_graph = Sale.revenue_data_for_graph
    @flavors = Flavor.includes(:location_flavors).order_by_name
  end
end
