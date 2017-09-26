class ThoughtsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @thought = current_user.thoughts.build(thought_params)
    if @thought.save
      flash[:success] = "Thought posted."
      redirect_to root_path
    else
      flash[:warning]="Please enter a thought."
      redirect_to root_path
    end
  end

  def destroy
    if correct_user? || current_user.admin?
      Thought.find(params[:id]).destroy
      flash[:success] = "Thought deleted."
      redirect_to root_path
    else
      flash[:danger] = "Not permitted."
      redirect_to root_path
    end
  end

  private
    def thought_params
      params.require(:thought).permit(:content)
    end

    def correct_user?
      current_user == Thought.find(params[:id]).user
    end
end
