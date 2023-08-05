class AddSendReportAtToSystemConfigurations < ActiveRecord::Migration[7.1]
  def change
    add_column :system_configurations, :send_report_at, :datetime
  end
end
