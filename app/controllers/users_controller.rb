class UsersController < ApplicationController
  before_action :logged_in_user, only:[:edit, :update, :show, :index]
  before_action :correct_user, only:[:edit, :update]
  before_action :admin, only:[:destroy]

  def index
    @user = User.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Thinkr."
      redirect_to @user
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

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
       @user = User.find(params[:id])
       unless @user == current_user
         flash[:warning] = "You don't have permission to do that!"
         redirect_to(root_path)
       end
    end

    def logged_in_user
      unless logged_in?
        flash[:warning] = "Please log in!"
        redirect_to login_path
      end
    end

    def admin
      unless current_user.admin?
        flash[:danger] = "You don't have permission to do that!"
        redirect_to root_path
      end
    end
end
