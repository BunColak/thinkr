class SessionsController < ApplicationController
  def new
  end

  def create
    # Find the user, if it exists and password is correct login and redirect to profile
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        if params[:session][:remember_me] == '1'
          remember user
        else
          forget user
        end
        redirect_to user
      else
        flash[:danger] = "Account is not activated!\nPlease check your email!"
        redirect_to root_path
      end
    else
      # If user does not exist or password is invalid give error with flash
      # Could make it more detailed with extra if statements
      flash.now[:danger] = "Email or password is invalid."
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
