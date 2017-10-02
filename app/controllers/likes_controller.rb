class LikesController < ApplicationController

  def create
    thought = Thought.find(params[:thought_id])
    current_user.like thought
    redirect_to root_path
  end

  def destroy
    thought = Like.find_by(thought_id:params[:id]).thought
    current_user.unlike thought
    redirect_to root_path
  end
end
