class AddConfirmedAtToRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :confirmed_at, :date
  end
end
