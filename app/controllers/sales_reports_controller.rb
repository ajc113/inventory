# frozen_string_literal: true

class SalesReportsController < ApplicationController
  def show
    result = BuildSalesReportService.call(params)

    @sales_data = result.data
    @date = params[:date].to_date
  end
end
