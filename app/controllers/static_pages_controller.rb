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
      redirect_to root_path
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


  private
  
    def post_params
      params.require(:post).permit(:title, :topic_ids, :content, :user_id, :post_id, :superpid)
    end
  
    def login_check
      if !logged_in?
          flash[:warning] = "You should login first to see the content!"
          redirect_to root_path
      end
    end
    
    
    def find_post
      @post = Post.find(params[:id])
    end
end
