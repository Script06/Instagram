class PostsController < ApplicationController
  # для ленты постов
  def index
    @posts = Post.all
    @comment = Comment.new
  end
end
