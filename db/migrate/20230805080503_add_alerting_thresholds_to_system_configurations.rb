class AddAlertingThresholdsToSystemConfigurations < ActiveRecord::Migration[7.1]
  def change
    add_column :system_configurations, :alerting_sale, :integer, default: 0
    add_column :system_configurations, :alerting_inventory, :integer, default: 0
    add_column :system_configurations, :alerting_production, :integer, default: 0
  end
end
