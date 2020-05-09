class SessionsController < ApplicationController
  def new

  end
=begin params[:session][:password] contains all the information for
       validating users credentials 
=end
  def create
    user = User.find_by(email: params[:session][:email].downcase) 
    if user&.authenticate(params[:session][:password])
      log_in user
      redirect_to user   
    else 
      flash.now[:danger] = 'Invalid email/password combination' #with flash.now the message won't be consistent on other page
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
