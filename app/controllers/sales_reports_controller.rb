# frozen_string_literal: true

class SalesReportsController < ApplicationController
  before_action :set_start_end_date

  def show
    result = SalesReports::CustomRangeService.call(params)
    @sales_data = result.data

    if params["export-csv"]
      sales_csv_data = GenerateSalesCsvData.call(@sales_data)
      send_data sales_csv_data, filename: "sales_report#{@start_date}-#{@end_date}.csv"
    end
  end

  private

  def set_start_end_date
    @start_date = params[:start_date].to_date

    @end_date = params[:end_date].to_date
  end
end
