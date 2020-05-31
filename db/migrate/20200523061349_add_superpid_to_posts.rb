class AddSuperpidToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :superpid, :integer
  end
end
