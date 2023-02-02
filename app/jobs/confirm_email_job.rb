class ConfirmEmailJob < ApplicationJob
  queue_as :default

  def perform(request)
    request.update(expired: true) unless request.email_confirmation
  end
end
