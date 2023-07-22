class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"

  def from(from_address)
    from_address.presence || "from@example.com"
  end
end
