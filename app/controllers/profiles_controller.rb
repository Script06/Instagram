class ProfilesController < ApplicationController
  before_action :set_user, only: %i[index]

  def index
    redirect_to user_posts_path if @user.username == current_user.username
    if @user
      @posts = Post.where(user_id: @user.id)
    else
      # handle when user not found
    end
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
