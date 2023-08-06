# frozen_string_literal: true

class SalesReportsController < ApplicationController
  before_action :set_start_end_date

  def show
    return redirect_back(fallback_location: redirect_path, alert: start_date_blank) if params[:start_date].blank?
    return redirect_back(fallback_location: redirect_path, alert: invalid_range) if @start_date > @end_date

    result = SalesReports::CustomRangeService.call(params)
    @sales_data = result.data

    if params["export-csv"]
      sales_csv_data = GenerateSalesCsvData.call(@sales_data)
      send_data sales_csv_data, filename: "sales_report#{@start_date}-#{@end_date}.csv"
    end
  end

  private

  def set_start_end_date
    @start_date = params[:start_date]&.to_date

    @end_date = params[:end_date].present? ? params[:end_date].to_date : Date.today
  end

  def redirect_path
    sales_report_path(start_date: @start_date, end_date: @end_date)
  end

  def start_date_blank
    'Please select start date'
  end

  def invalid_range
    'Start date must be before the End date'
  end
end
