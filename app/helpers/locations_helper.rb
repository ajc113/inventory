module LocationsHelper
  def flavor_options_for_select(location)
    Flavor.all.map { |flavor| [flavor.name, flavor.id] }
  end
end
