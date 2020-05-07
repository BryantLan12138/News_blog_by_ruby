class SessionsController < ApplicationController
  def new

  end
=begin params[:session][:password] contains all the information for
       validating users credentials 
=end
  def create
    user = User.find_by(email: params[:session][:email].downcase) 
    if user && user.authenticate(params[:session][:password]) 
    else 
      flash.now[:danger] = 'Invalid email/password combination' #with flash.now the message won't be consistent on other page
      render 'new'
    end
  end

  def destroy

  end

end
