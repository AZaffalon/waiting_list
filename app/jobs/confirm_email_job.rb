class ConfirmEmailJob < ApplicationJob
  queue_as :default

  def perform(request)
    request.update(request.email_confirmation ? { accepted: true } : { expired: true })
  end
end
