class Request < ApplicationRecord
  after_create :send_confirm_email

  validates :name, :email, :phone_number, :biography, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates_format_of :phone_number, with: /^(?:(?:(?:\+|00)33[ ]?(?:\(0\)[ ]?)?)|0){1}[1-9]{1}([ .-]?)(?:\d{2}\1?){3}\d{2}$/i, on: :create, multiline: true

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

  def send_confirm_email
    RequestMailer.confirm_email(self).deliver_now
  end

end
