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

  # Accept a request
  def accept!
    self.update_attribute(:accepted, true)
  end

  # Format phone_number in e164 before saving it
  def format_phone_number
    self.phone_number = Phonelib.parse(self.phone_number).e164
  end

  def send_confirm_email
    RequestMailer.confirm_email(self).deliver_now
  end

end
