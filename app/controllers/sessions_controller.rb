class SessionsController < ApplicationController

  def new
  end

  

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'Congratulations! Login successfully!'
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "Log out successfully!"
    redirect_to root_path
  end

  private
  
  def login
    if logged_in?
      redirect_to root_path
    end
  end
end