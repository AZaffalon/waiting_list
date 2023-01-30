class ChangePhoneNumberFromIntegerToString < ActiveRecord::Migration[7.0]
  def change
    change_column :requests, :phone_number, :string, null: false
  end
end
