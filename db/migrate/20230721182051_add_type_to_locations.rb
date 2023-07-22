class AddTypeToLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :inventory, :boolean, default: false
  end
end
