class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :view, :default =>0

      t.timestamps
    end
    add_index :posts, [:user_id, :created_at]
  end
end
