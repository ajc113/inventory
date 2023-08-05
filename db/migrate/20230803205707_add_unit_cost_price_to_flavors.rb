class AddUnitCostPriceToFlavors < ActiveRecord::Migration[7.1]
  def change
    add_column :flavors, :price, :float, default: 0
    add_column :flavors, :unit_cost, :float, default: 0
  end
end
