class DashboardController < ApplicationController
  def show
    @locations = Location.all
    @flavors = Flavor.includes(:location_flavors).order_by_name
  end
end