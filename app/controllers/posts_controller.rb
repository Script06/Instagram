class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    post_params
    #debugger
    post = Post.create(post_params)
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:body, images: []).merge(user_id: current_user.id)
    end

end