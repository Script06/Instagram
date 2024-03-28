class ProfilesController < ApplicationController
  def index
    @user = User.find_by(username: params[:username])
    redirect_to user_posts_path if @user.username == current_user.username
    if @user
      @posts = Post.where(user_id: @user.id)
    else
      # handle when user not found
    end
  end
end
