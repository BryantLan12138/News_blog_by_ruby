class AddLogincountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :logincount, :integer, :default => 1
  end
end
