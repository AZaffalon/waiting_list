class RequestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.request_mailer.confirm_email.subject
  #
  def confirm_email(request)
    @request = request
    mail to: request.email
  end
end
