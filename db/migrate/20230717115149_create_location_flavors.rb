class CreateLocationFlavors < ActiveRecord::Migration[7.1]
  def change
    create_table :location_flavors do |t|
      t.integer :quantity, default: 0
      t.integer :inventory, default: 0
      t.belongs_to :flavor, null: false
      t.belongs_to :location, null: false
      t.index [:flavor_id, :location_id], unique: true

      t.timestamps
    end
  end
end
