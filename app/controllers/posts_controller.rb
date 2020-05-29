class PostsController < ApplicationController
  before_action :login_check, only: [:show, :new, :create]
  before_action :find_post, only: [:destroy]

  def selectedPost
    
    @topic_ids = params[:topics].split(",")
    
    puts "---------------------#{@topic_ids}-----------------------------"
    if !@topic_ids.nil?
      @list = Post.where(post_id: nil).order("view DESC")
      @topics = Topic.all
    else
      redirect_to root_path
    end
    
  end
  
  

  def show
    @post = Post.find(params[:id])
    @post.view = @post.view + 1
    @post.save
    @comment = Post.new
    @comments = Post.where("post_id is NOT NULL AND title = ?", @post.title).sort_by {|x| [x.created_at]}.reverse
  end

 
  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      if @post.topic.empty?
        PostsTopic.create(topic_id:16, post_id: @post.id)
      end
      flash[:success] = "You just made a new post!"
      redirect_to post_url(Post.where("post_id is NULL AND title = ?",@post.title)[0].id)
    else
      @feed_items = []
      render new_post_path
    end
  end
  
  def destroy
    
    apost = Post.find_by("post_id = ?" , @post.id)
    if !apost.nil? && !apost.post_id.nil?
      apost.update_attribute(:post_id, apost.id)
    end
    
    @post.destroy
    flash[:success] = "Your post/comment is deleted!"
    redirect_back(fallback_location: root_path)
    
  end
    
    
  private
  
    def post_params
      params.require(:post).permit(:title, :topic_ids, :content, :user_id, :post_id, :superpid)
    end
  
    def login_check
      if !logged_in?
          flash[:warning] = "You must login to create a post!"
          redirect_to root_path
      end
    end
    
    
    def find_post
      @post = Post.find(params[:id])
    end
  
end
