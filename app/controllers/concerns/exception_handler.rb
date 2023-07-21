# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing do |_exception|
      flash[:alert] = 'Required params is missing for this request.'
      redirect_back(fallback_location: root_path)
    end

    rescue_from ActiveRecord::RecordNotFound do |_exception|
      flash[:alert] = 'Record not found.'
      redirect_back(fallback_location: root_path)
    end
  end
end
