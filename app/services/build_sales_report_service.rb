class BuildSalesReportService < ApplicationService
  attr_reader :date, :params

  def initialize(params)
    @params = params
    @date = params.fetch(:date, Date.today).to_date
  end

  def call
    sales_data = {}

    stores.each do |store|
      sales_data[store.name] = {}

      store.flavors.each do |flavor|
        sales = store.sales.where(flavor: flavor, created_at: date.beginning_of_day..date.end_of_day)

        next unless sales.present?

        starting_inventory = starting_inventory(store, flavor, sales)
        end_of_day_inventory = end_of_day_inventory(starting_inventory, sales)
        daily_usage = daily_usage(starting_inventory, end_of_day_inventory)

        sales_data[store.name][flavor.name] = {
          usage: daily_usage,
          starting_inventory: starting_inventory,
          end_of_day_inventory: end_of_day_inventory
        }
      end
    end

    ServiceResponse.new(data: sales_data)
  end

  private

  def starting_inventory(store, flavor, sales)
    today_sales_quantity = sales.sum(:quantity)
    inventory = flavor.location_flavors.find_by(location: store).inventory

    inventory + today_sales_quantity
  end

  def end_of_day_inventory(starting_inventory, sales)
    starting_inventory - sales.sum(:quantity)
  end

  def daily_usage(starting_inventory, end_of_day_inventory)
    starting_inventory - end_of_day_inventory
  end

  def stores
    store_ids = params.fetch(:store_id, Store.all.pluck(:id))

    Store.where(id: store_ids).includes(:sales)
  end
end
