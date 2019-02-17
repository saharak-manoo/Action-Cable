class HomesController < ApplicationController
  before_action :authenticate_user!

  def index

    unless current_user
      redirect_to new_user_session_path
    end
  end

  def new_feed
    ap 'new_feed'
  end

  def comment
    ap 'comment'
  end
end
