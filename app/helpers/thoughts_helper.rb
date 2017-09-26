module ThoughtsHelper
  def correct_user?
    current_user == Thought.find(params[:id]).user
  end
end
