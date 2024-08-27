class PostsController < ApplicationController
  # для ленты постов
  def index
    @posts = Post.all
  end
end
