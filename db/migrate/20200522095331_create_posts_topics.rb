class CreatePostsTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :posts_topics do |t|
      t.references :topic, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
