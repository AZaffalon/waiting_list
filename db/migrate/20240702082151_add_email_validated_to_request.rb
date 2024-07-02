class AddEmailValidatedToRequest < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :email_validated, :boolean, default: false
  end
end
