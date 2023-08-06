module SalesReports
  class DailyService < ApplicationService
    attr_reader :date, :params

    def initialize(params)
      @params = params
      @date = params.fetch(:date, Date.today).to_date
    end

    def call
      generate_sales_data
    end

    private

    def initialize_sales_data
      {
        total: {
          profit: 0,
          revenue: 0,
          total_sales: 0,
          starting_inventory: 0,
          end_of_day_inventory: 0
        },
        stores: {},
        inventories: {}
      }
    end

    def generate_sales_data
      sales_data = initialize_sales_data

      stores.each do |store|
        store_data = generate_store_data(store)
        append_store_totals(store, sales_data, store_data)
        sales_data[:stores][store.name] = store_data
      end

      inventories.each do |inventory|
        inventory_data = generate_inventory_data(inventory)
        sales_data[:inventories][inventory.name] = inventory_data
        append_inventory_totals(inventory, sales_data, inventory_data)
      end

      append_totals(sales_data)

      ServiceResponse.new(data: sales_data)
    end

    def generate_inventory_data(inventory)
      flavors = inventory.flavors.includes(:location_flavors).order_by_name

      flavors.each_with_object({}) do |flavor, data|
        productions = inventory.productions.where(flavor: flavor, created_at: date.beginning_of_day..date.end_of_day)
        productions_sum = productions.sum(:quantity).to_f

        data[flavor.name] = { production_quantity: productions_sum }
      end
    end

    def generate_store_data(store)
      flavors = store.flavors.includes(:location_flavors).order_by_name

      flavors.each_with_object({}) do |flavor, data|
        sales = store.sales.where(flavor: flavor, created_at: date.beginning_of_day..date.end_of_day)
        sales_sum = sales.sum(:quantity).to_f

        starting_inventory = calculate_starting_inventory(store, flavor, sales_sum)
        end_of_day_inventory = calculate_end_of_day_inventory(starting_inventory, sales_sum)
        total_sale_value = calculate_total_sale(starting_inventory, end_of_day_inventory)
        revenue = flavor.price * sales_sum
        profit = revenue - (flavor.unit_cost * sales_sum)

        data[flavor.name] = {
          profit: profit,
          revenue: revenue,
          total_sale: total_sale_value,
          starting_inventory: starting_inventory,
          end_of_day_inventory: end_of_day_inventory
        }
      end
    end

    def calculate_starting_inventory(store, flavor, today_sales_quantity)
      inventory = flavor.location_flavors.find{ |location_flavor| location_flavor.location_id == store.id }.inventory

      inventory + today_sales_quantity
    end

    def calculate_end_of_day_inventory(starting_inventory, today_sales_quantity)
      starting_inventory - today_sales_quantity
    end

    def calculate_total_sale(starting_inventory, end_of_day_inventory)
      starting_inventory - end_of_day_inventory
    end

    def stores
      store_ids = params[:store_id].presence || Store.pluck(:id)

      Store.where(id: store_ids).includes(:sales)
    end

    def inventories
      Inventory.all.includes(:productions)
    end

    def append_inventory_totals(inventory, sales_data, inventory_data)
      production_quantity = 0

      inventory_data.each_value do |data|
        production_quantity += data[:production_quantity].to_i
      end

      sales_data["#{inventory.name}_totals"] = {
        production_quantity: production_quantity
      }
    end

    def append_store_totals(store, sales_data, store_data)
      store_profit = 0
      store_revenue = 0
      store_total_sales = 0
      store_starting_inventory = 0
      store_end_of_day_inventory = 0

      store_data.each_value do |data|
        store_profit += data[:profit].to_i
        store_revenue += data[:revenue].to_i
        store_total_sales += data[:total_sale].to_i
        store_starting_inventory += data[:starting_inventory].to_i
        store_end_of_day_inventory += data[:end_of_day_inventory].to_i
      end

      sales_data["#{store.name}_totals"] = {
        profit: store_profit,
        revenue: store_revenue,
        total_sale: store_total_sales,
        starting_inventory: store_starting_inventory,
        end_of_day_inventory: store_end_of_day_inventory
      }
    end

    def append_totals(sales_data)
      sales_data[:stores].each_value do |flavors|
        flavors.each_value do |data|
          sales_data[:total][:profit] += data[:profit].to_i
          sales_data[:total][:revenue] += data[:revenue].to_i
          sales_data[:total][:total_sales] += data[:total_sale].to_i
          sales_data[:total][:starting_inventory] += data[:starting_inventory].to_i
          sales_data[:total][:end_of_day_inventory] += data[:end_of_day_inventory].to_i
        end
      end
    end
  end
end
