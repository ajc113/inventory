class CreateFlavors < ActiveRecord::Migration[7.0]
  def change
    create_table :flavors do |t|
      t.string :name
      t.string :instock
      t.integer :quantity

      t.timestamps
    end
  end
end
