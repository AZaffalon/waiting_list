class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.text :name,                 null: false
      t.text :email,                null: false
      t.boolean :email_confirmation,  default: false
      t.integer :phone_number,        null: false
      t.text :biography,              null: false
      t.boolean :accepted,            default: false

      t.timestamps
    end
  end
end
