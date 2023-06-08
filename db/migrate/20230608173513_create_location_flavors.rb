class CreateLocationFlavors < ActiveRecord::Migration[7.0]
  def change
    create_table :location_flavors do |t|
      t.references :flavor, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
