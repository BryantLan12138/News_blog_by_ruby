class SessionsController < ApplicationController
  before_action :login, only: [:new, :create]
  def new
  end

  

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&&user.authenticate(params[:session][:password])
      #user login in 7 days, the num of login in 7days will be count.
      #Otherwise recount the times.

      if DateTime.now.to_i - 7.days <= user.lasttime.to_i
        user.lasttime = DateTime.now
        user.logincount = user.logincount + 1
        user.save
      else
        user.lasttime = DateTime.now
        user.logincount = 1
        user.save
      end
      
      log_in(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'Congratulations! Login successfully!'
      redirect_to root_path
    else
      flash[:danger] = 'Wrong email and password! Please check you detail and try again!'
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