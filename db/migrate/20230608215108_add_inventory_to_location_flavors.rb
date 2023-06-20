class AddInventoryToLocationFlavors < ActiveRecord::Migration[7.0]
  def change
    add_column :location_flavors, :inventory, :integer
  end
end
