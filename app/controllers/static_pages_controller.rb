class StaticPagesController < ApplicationController
  def home
    if params[:keywords].nil?
      @posts = Post.where(post_id: nil).order("created_at DESC")
      @pervious_input = nil
    else
      @posts = Post.where("post_id IS NULL AND title like ?", "%#{params[:keywords].to_s}%").order("view DESC")
      @pervious_input = params[:keywords].to_s
    end
    
    @list = Post.where(post_id: nil).order("view DESC")
    @topics = Topic.all
  end
  
  def selectedPost
    
    @topic_ids = params[:topics].split(",")
    
    puts "---------------------#{@topic_ids}-----------------------------"
    if !@topic_ids.nil?
      @list = Post.where(post_id: nil).order("view DESC")
      @topics = Topic.all
    else
      redirect_to news_path
    end
    
  end

  def news
    @posts = Post.where(post_id: nil).order("created_at DESC")
    @post = Post.find(params[:id])
    @post.view = @post.view + 1
    @post.save
    @comment = Post.new
    @comments = Post.where("post_id is NOT NULL AND superpid = ?", @post.superpid).reverse
    @list = Post.where(post_id: nil).order("view DESC")
    @topics = Topic.all
  end
end
