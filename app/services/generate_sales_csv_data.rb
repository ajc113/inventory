# frozen_string_literal: true
require 'csv'

class GenerateSalesCsvData < ApplicationService
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def call
    csv_data = CSV.generate do |csv|
      csv << ['Store', 'Flavor', 'Sales', 'Productions', 'Transfers', 'Revenue', ' Profit']

      data.each do |location, flavors|
        flavors.each do |flavor_name, flavor_data|
          row = [
            location,
            flavor_name,
            flavor_data[:sales_sum],
            flavor_data[:productions_sum],
            flavor_data[:transfers_sum],
            flavor_data[:profit],
            flavor_data[:revenue]
          ]
          csv << row
        end
      end
    end

    csv_data
  end
end
