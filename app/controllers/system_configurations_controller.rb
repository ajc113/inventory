# frozen_string_literal: true

class SystemConfigurationsController < ApplicationController
  before_action :authorize_user

  def show
    @system_configuration = SystemConfiguration.first_or_create
  end

  def edit
    @system_configuration = SystemConfiguration.first_or_initialize
  end

  def update
    @system_configuration = SystemConfiguration.first_or_initialize(system_configuration_params)

    if @system_configuration.update(system_configuration_params)
      redirect_to system_configuration_path, notice: 'Updated successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def system_configuration_params
    params.require(:system_configuration).permit(:alerting_quantity, :alerting_sale, :alerting_daily_sale, :alerting_daily_per_store_sale,
      :alerting_production, :alerting_daily_inventory, :alerting_daily_per_store_inventory, :send_report_at, report_recipients: [])
  end

  def authorize_user
    authorize SystemConfiguration.first_or_create
  end
end
