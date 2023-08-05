module ApplicationHelper
  def currency(amount)
    number_to_currency amount, precision: 0
  end
end
