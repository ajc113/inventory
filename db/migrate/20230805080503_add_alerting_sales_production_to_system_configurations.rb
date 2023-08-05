class AddAlertingSalesProductionToSystemConfigurations < ActiveRecord::Migration[7.1]
  def change
    add_column :system_configurations, :alerting_sale, :integer
    add_column :system_configurations, :alerting_production, :integer
  end
end
