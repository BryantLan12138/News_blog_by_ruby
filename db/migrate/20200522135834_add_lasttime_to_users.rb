class AddLasttimeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :lasttime, :timestamp
  end
end
