# frozen_string_literal: true

class SystemConfigurationsController < ApplicationController
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
    params.require(:system_configuration).permit(:alerting_quantity)
  end
end
