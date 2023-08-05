class DailySalesReportController < ApplicationController
  def show
    result = SalesReports::DailyService.call(params)

    @sales_data = result.data
    @date = params[:date].to_date
    @system_configuration = SystemConfiguration.first
  end
end
