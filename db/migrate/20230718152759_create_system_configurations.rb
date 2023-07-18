class CreateSystemConfigurations < ActiveRecord::Migration[7.1]
  def change
    create_table :system_configurations do |t|
      t.integer :alerting_quantity

      t.timestamps
    end
  end
end
