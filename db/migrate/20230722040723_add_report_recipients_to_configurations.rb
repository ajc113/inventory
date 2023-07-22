class AddReportRecipientsToConfigurations < ActiveRecord::Migration[7.1]
  def change
    add_column :system_configurations, :report_recipients, :string, array: true, default: []
  end
end
