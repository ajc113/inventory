module LocationsHelper
  def flavor_options_for_select
    Flavor.active.order(name: :asc)
  end
end
