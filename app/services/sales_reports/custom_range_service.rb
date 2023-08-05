module SalesReports
  class CustomRangeService < ApplicationService
    attr_reader :start_date, :end_date, :params

    def initialize(params)
      @params = params
      @start_date = params[:start_date].to_date
      @end_date = params[:end_date].present? ? params[:end_date].to_date : Date.today
    end

    def call
      sales_data = {}

      stores.each do |store|
        sales_data[store.name] = {}

        store.flavors.order_by_name.each do |flavor|
          if params[:flavor_id].blank? || selected_flavor.id == flavor.id
            sales = store.sales.where(flavor: flavor, created_at: date_range)
            productions = Production.where(flavor: flavor, created_at: date_range)
            transfers = store.transfers.where(flavor: flavor, created_at: date_range)

            sales_sum = sales&.sum(&:quantity)
            transfers_sum = transfers&.sum(&:quantity)
            productions_sum = productions&.sum(&:quantity)
            revenue = flavor.price * sales_sum
            profit = revenue - (flavor.unit_cost * sales_sum)

            sales_data[store.name][flavor.name] = {
              profit:,
              revenue:,
              sales_sum:,
              transfers_sum:,
              productions_sum:
            }
          end
        end
      end

      ServiceResponse.new(data: sales_data)
    end

    private

    def date_range
      start_date.beginning_of_day..end_date.end_of_day
    end

    def selected_flavor
      @selected_flavor ||= Flavor.find(params[:flavor_id])
    end

    def stores
      store_ids = params[:store_id].present? ? params[:store_id] : Store.all.pluck(:id)
  
      Store.where(id: store_ids).includes(:sales)
    end
  end
end
