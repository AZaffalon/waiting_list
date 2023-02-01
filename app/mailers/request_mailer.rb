class RequestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.request_mailer.confirm_email.subject
  #
  def confirm_email(request)
    @request = request
    mail to: request.email
    mail subject: 'Confirm your email'
  end

  def reconfirm_email(request)
    @request = request
    # Todo -> define a variable returning the position of the request in the waiting list
    mail to: request.email
    mail subject: 'Re-confirm your email'
  end
end
