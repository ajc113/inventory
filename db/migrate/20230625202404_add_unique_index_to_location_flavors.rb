class AddUniqueIndexToLocationFlavors < ActiveRecord::Migration[7.0]
  def change
    add_index :location_flavors, [:flavor_id, :location_id], unique: true
  end
end
