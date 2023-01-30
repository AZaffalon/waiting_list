class Request < ApplicationRecord
  validates :name, :email, :phone_number, :biography, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates_format_of :phone_number, with: /^(?:(?:(?:\+|00)33[ ]?(?:\(0\)[ ]?)?)|0){1}[1-9]{1}([ .-]?)(?:\d{2}\1?){3}\d{2}$/i, on: :create, multiline: true


  # Accept a request
  def accept!
    self.update_attribute(:accepted, true)
  end

end
