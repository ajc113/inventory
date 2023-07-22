# frozen_string_literal: true

class TransfersController < ApplicationController

  def new
    @transfer = Transfer.new
  end

  def create
    result = TransferService.call(params)

    @transfer = result.data
    @errors = result.meta[:message] unless result.valid?

    if result.valid?
      redirect_back(fallback_location: root_path, notice: result.meta[:message])
    else
      render :new, status: :unprocessable_entity
    end
  end
end
