module LocationsHelper
  def flavor_options_for_select
    Flavor.active.order_by_name
  end
end
