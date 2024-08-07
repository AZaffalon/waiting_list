class Request < ApplicationRecord
  before_save :format_phone_number

  after_create :send_confirm_email

  validates :name, :email, :phone_number, :biography, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates :phone_number, phone: { countries: :fr }

  # Request with email not confirmed yet
  scope :unconfirmed, -> { where(email_confirmation: false) }
  # Request with email confirmed
  scope :confirmed, -> { where(email_confirmation: true) }
  # Requests accepted to the waiting list
  scope :accepted, -> { where(accepted: true) }
  # Request not accepted to the waiting list yet
  scope :unaccepted, -> { where(accepted: false) }
  # Requests that have not been reconfirmed
  scope :expired, -> { where(expired: true) }

  scope :unexpired, -> { where(expired: false) }

  # Accept a request
  def self.accept!
    Request.confirmed.order(:created_at).first.update(accepted: true)
  end

  # Format phone_number in e164 before saving it
  def format_phone_number
    self.phone_number = Phonelib.parse(phone_number).e164
  end

  def send_confirm_email
    RequestMailer.confirm_email(self).deliver_later
  end

  # Send a second email to confirm for the last time if the user is still interested
  def self.send_reconfirm_email
    # For all requests that have been accepted but not confirmed yet
    Request.confirmed.unaccepted.unexpired.each do |request|
      # three_months_from_last_confirmed = request.confirmed_at + 3.months

      # next unless three_months_from_last_confirmed == Date.today
      next unless request.confirmed_at == Date.today

      # Send email to reconfirm email
      RequestMailer.reconfirm_email(request).deliver_later

      # Check if email_validated is true, else -> change expired to true
      # ConfirmEmailJob.set(wait: 2.days).perform_later(request)

      ConfirmEmailJob.set(wait: 1.minute).perform_later(request)
    end
  end
end
