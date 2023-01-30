class Request < ApplicationRecord
  validates :name, :email, :phone_number, :biography, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP



  # Accept a request
  def accept!
    self.update_attribute(:accepted, true)
  end
end
