class CreateFlavors < ActiveRecord::Migration[7.1]
  def change
    create_table :flavors do |t|
      t.string :name, null: false
      t.boolean :archived, default: false
      t.integer :quantity, default: 0
      t.integer :inventory, default: 0

      t.timestamps
    end
  end
end
