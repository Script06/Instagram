class PostsController < ApplicationController
  before_action :set_post, only: %i[update]
  def new
    @post = Post.new
  end

  def create
    post_params
    @post = Post.create(post_params)
    flash[:notice] = 'Пост успешно создан'
    redirect_to root_path
  end

  # для ленты постов
  def index
    @posts = Post.all
  end

  def update
    @post.update(post_params)
    attachments = ActiveStorage::Attachment.where(id: params[:deleted_img_ids])
    attachments.map(&:purge)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body, images: []).merge(user_id: current_user.id)
  end
end
