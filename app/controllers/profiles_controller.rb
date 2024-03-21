class ProfilesController < ApplicationController
  def index
    user = User.find_by(username: params[:username])
    if user
      @posts = Post.where(user_id: user.id)
    else
      # handle when user not found
    end
  end
end
