class UsersController < ApplicationController
  before_action :logged_in_user, only:[:edit, :update, :show, :index, :destroy]
  before_action :admin, only:[:destroy]
  before_action :correct_user, only:[:edit, :update]

  def index
    @user = User.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @thoughts = @user.thoughts.paginate(page: params[:page], per_page: 10)
    @thought = current_user.thoughts.build if logged_in?
  end

  def create
    @user = User.new user_params
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_path
    else
      render 'new'
    end
  end

  def delete

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile saved."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted!"
    redirect_to root_path
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page], per_page: 10)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], per_page: 10)
    render 'show_follow'
  end


  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
       @user = User.find(params[:id])
       unless (@user == current_user || current_user.admin?)
         flash[:warning] = "You don't have permission to do that!"
         redirect_to(root_path)
       end
    end

    def admin
      unless current_user.admin?
        flash[:danger] = "You don't have permission to do that!"
        redirect_to root_path
      end
    end
end
