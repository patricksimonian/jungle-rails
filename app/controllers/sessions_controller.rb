class SessionsController < ApplicationController

  def create
    flash.clear
    # see user model
    user = User.authenticate_with_credentials(params[:session][:email], params[:session][:password])
    if user
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/'
    else
    # If user's login doesn't work, send them back to the login form.
      flash[:error] = "username or password incorrect"
      redirect_to "/"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
