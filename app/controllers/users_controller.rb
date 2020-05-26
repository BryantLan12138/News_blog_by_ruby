class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.where("post_id is NULL")
    @comments = @user.posts.where("post_id is NOT NULL")
  end

  def new 
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Successfully created account - #{@user.name}"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
        render 'edit'
    end
  end

  def myposts
    @user = current_user
    @posts = @user.posts.where("post_id is NULL")
    
  end
  
  def mycomments
    @user = current_user
    @comments = @user.posts.where("post_id is NOT NULL")
  end
  
  def commentstome
    @commtome = Post.where('post_id is NOT NULL')
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, 
                                :password, :password_confirmation, 
                                :phone, :image, :city, :card, 
                                :intro,:lasttime)
  end

  def logged_in_user 
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end 
  end

  def correct_user
    @user = User.find(params[:id]) 
    redirect_to(root_url) unless current_user?(@user)
  end

  
  def mycomments
    @user = current_user
    @comments = @user.posts.where("post_id is NOT NULL")
  end
  
  def commentstome
    @commtome = Post.where('post_id is NOT NULL')
  end

  helper_method :mycomments
end


