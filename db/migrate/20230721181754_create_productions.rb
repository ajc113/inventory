class CreateProductions < ActiveRecord::Migration[7.1]
  def change
    create_table :productions do |t|
      t.integer :quantity, null: false
      t.belongs_to :flavor, null: false
      t.belongs_to :location, null: false

      t.timestamps
    end
  end
end
