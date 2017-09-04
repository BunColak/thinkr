class SessionsController < ApplicationController
  def new
  end

  def create
    # Find the user, if it exists and password is correct login and redirect to profile
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      # If user does not exist or password is invalid give error with flash
      # Could make it more detailed with extra if statements
      flash.now[:danger] = "Email or password is invalid."
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
