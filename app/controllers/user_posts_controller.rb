class UserPostsController < ApplicationController
  def index
    @posts = Post.all
    debugger
  end
end
