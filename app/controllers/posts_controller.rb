class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    post_params
    post = Post.create(post_params)
    flash[:notice] = "Пост успешно создан"
    redirect_to root_path
  end

  #для ленты постов
  def index
    @posts = Post.all
  end

  #Для показа постов конкретного пользователя
  def show
    
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:body, images: []).merge(user_id: current_user.id)
    end
end