class CommentController < ApplicationController
  
  
  
  def new
    @comment = Post.new
  end
  
  def create
    @comment = current_user.posts.build(comment_params)
    if @comment.save
      flash[:success] = "You just made a new post!"
      redirect_to news_path
    else
      @feed_items = []
      render new_post_path
    end
  end
  
  
  
  private
    def comment_params
      params.require(:comment).permit(:title, :topic_ids, :content, :user_id, :post_id)
    end
  
  
  
end
