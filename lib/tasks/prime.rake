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
      { name: 'Coffee' },
      { name: 'Cookie Dough' },
      { name: 'Double Cookie' },
      { name: 'Black Raspberry' },
      { name: 'Mint Chip' },
      { name: 'Black Rasp Oreo' },
      { name: 'Chocolate' },
      { name: 'Cookie Dough M&M' },
      { name: 'Key Lime Pie' },
      { name: 'Strawberry' },
      { name: 'Vanilla' },
      { name: 'Watermelon' },
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

          LocationFlavor.find_or_create_by!(
            flavor: flavor, location: location
          ) do |location_flavor|
            location_flavor.quantity = quantity
            location_flavor.inventory = inventory
          end
        end
      end
    end

    15.times do |day|
      10.times do |flavor|
        Sale.create!(
          quantity: rand(1..15),
          flavor_id: flavors_ids.sample,
          location: Store.all.sample,
          created_at: day.days.ago
        )

        Production.create!(
          quantity: rand(1..15),
          flavor_id: flavors_ids.sample,
          location: Inventory.all.sample,
          created_at: day.days.ago
        )
      end
    end

    puts 'Test data has been seeded successfully!'
  end
end
