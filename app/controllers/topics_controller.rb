class TopicsController < ApplicationController
  def new
  end
  
  def show
    
    @topic = Topic.find(params[:id])
    @posts = @topic.post.where(post_id: nil).order("created_at DESC")
    @list = Post.where(post_id: nil).order("view DESC")
    @topics = Topic.all
    
  end
  
  
end