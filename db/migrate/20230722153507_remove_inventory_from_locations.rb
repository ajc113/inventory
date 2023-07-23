class RemoveInventoryFromLocations < ActiveRecord::Migration[7.1]
  def change
    remove_column :locations, :inventory, :boolean
  end
end
