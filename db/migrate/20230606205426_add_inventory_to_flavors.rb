class AddInventoryToFlavors < ActiveRecord::Migration[7.0]
  def change
    add_column :flavors, :inventory, :integer
  end
end
