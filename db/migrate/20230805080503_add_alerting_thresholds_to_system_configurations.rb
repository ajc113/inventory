class AddAlertingThresholdsToSystemConfigurations < ActiveRecord::Migration[7.1]
  def change
    add_column :system_configurations, :alerting_sale, :integer
    add_column :system_configurations, :alerting_daily_sale, :integer
    add_column :system_configurations, :alerting_daily_inventory, :integer
    add_column :system_configurations, :alerting_daily_per_store_sale, :integer
    add_column :system_configurations, :alerting_daily_per_store_inventory, :integer
    add_column :system_configurations, :alerting_production, :integer
  end
end
