# frozen_string_literal: true

namespace :dev do
  desc 'Prime the database with test data'
  task prime: :environment do
    # Seed Locations
    locations = ['Inventory', 'Kingston', 'Marshfield']
    locations.each_with_index do |location, index|
      Location.find_or_create_by!(name: location, type: index == 0 ? 'Inventory' : 'Store')
    end

    # Seed Flavors
    flavors_name = [
      { name: 'Flavor 1' },
      { name: 'Flavor 2' },
      { name: 'Flavor 3' },
      { name: 'Flavor 4' },
      { name: 'Flavor 5' }
    ]
    flavors_ids = []
    flavors_name.each do |flavor|
      flavors_ids << Flavor.find_or_create_by!(flavor).id
    end

    # Assign random inventory values to LocationFlavors
    LocationFlavor.transaction do
      locations = Location.all
      flavors = Flavor.where(id: flavors_ids)

      flavors.each do |flavor|
        locations.each do |location|
          quantity = rand(1..15)
          inventory = rand(1..15)

          location_flavor = LocationFlavor.new(
            flavor: flavor,
            location: location,
            quantity: quantity,
            inventory: inventory
          )
          location_flavor.save!
        end
      end
    end

    puts 'Test data has been seeded successfully!'
  end
end
