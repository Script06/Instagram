class UserPostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]
  before_action :authorize_user_post!
  # after_action :verify_authorized, except: %i[index]

  def index
    @posts = Post.where(user_id: current_user.id)
  end

  def new
    @post = Post.new
  end

  def create
    post_params
    @post = Post.create(post_params)
    flash[:notice] = 'Пост успешно создан'
    redirect_to root_path
  end

  def update
    @post.update(post_params)
    attachments = ActiveStorage::Attachment.where(id: params[:deleted_img_ids])
    attachments.map(&:purge)
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_posts_path, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
    flash[:notice] = 'пост удалён'
  end

  private

  def authorize_user_post!
    authorize(@post || Post)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body, images: []).merge(user_id: current_user.id)
  end
end
