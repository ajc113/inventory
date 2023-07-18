class DashboardController < ApplicationController
  def show
    @locations = Location.all
    @flavors = Flavor.order(name: :asc)
  end
end