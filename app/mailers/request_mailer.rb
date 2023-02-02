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
    waiting_list = Request.confirmed.unaccepted
    @position = waiting_list.index(request) + 1

    mail to: request.email
    mail subject: 'Re-confirm your email'
  end
end
