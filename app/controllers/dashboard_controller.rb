class DashboardController < ApplicationController
  def show
    @locations = Location.all
    @flavors = Flavor.includes(:location_flavors).order(name: :asc)
  end
end