class ThoughtsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @thought = current_user.thoughts.build(thought_params)
    if @thought.save
      flash[:success] = "Thought posted."
      redirect_to root_path
    else
      render 'static_pages/home'
    end
  end

  def destroy
    Thought.find(params[:id]).destroy
    flash[:success] = "Thought deleted."
    redirect_to root_path
  end

  private
    def thought_params
      params.require(:thought).permit(:content)
    end
end
