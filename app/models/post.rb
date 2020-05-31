class Post < ApplicationRecord
  has_many :post, dependent: :destroy
  belongs_to :user
  has_and_belongs_to_many :topic
  # default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  #validates :topic_ids, presence: true
  validates :title, presence: true, uniqueness: false
  validates :content, presence: true
  
  scope :with_posts, -> { joins(topic: :post) }
  
  
end
