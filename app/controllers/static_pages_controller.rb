class StaticPagesController < ApplicationController
  def home
    @thought = current_user.thoughts.build if logged_in?
    @thought_feed = current_user.feed.paginate(page: params[:page], per_page: 15)
  end

  def help
  end

  def about
  end

  def contact
  end
end
