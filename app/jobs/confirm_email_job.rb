class ConfirmEmailJob < ApplicationJob
  queue_as :default

  def perform(request)
    # Do something later
    RequestMailer.reconfirm_email(request).deliver_later(wait: 1.minutes) # TODO -> puts '3.months'
  end
end
