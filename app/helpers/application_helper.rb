module ApplicationHelper
  include Pagy::Frontend

  def currency(amount, precision = nil)
    number_to_currency amount, precision: precision
  end
end
