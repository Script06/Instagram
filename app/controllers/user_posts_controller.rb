# frozen_string_literal: true

class UserPostsController < ApplicationController
  before_action :post_params, only: %i[create]
  before_action :set_current_user, only: %i[index]
  before_action :set_post, only: %i[edit update destroy]
  before_action :authorize_user_post!, only: %i[edit update destroy]
  after_action :verify_authorized, only: %i[edit update destroy]

  def index
    @posts = Post.where(user_id: current_user.id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to root_path, notice: t('.success_post')
    else
      redirect_to root_path, notice: t('.error_post')
    end
  end

  def update
    if @post.update(post_params)
      attachments = ActiveStorage::Attachment.where(id: params[:deleted_img_ids])
      attachments.each(&:purge)

      redirect_to user_posts_path, notice: t('.success_update_post')
    else
      redirect_to user_posts_path, notice: t('.error_update_post')
    end
  end

  def edit; end

  def destroy
    if @post.destroy
      redirect_to user_posts_path, notice: t('.success_destroy_post')
    else
      redirect_to user_posts_path, notice: t('.error_destroy_post')
    end
  end

  private

  def authorize_user_post!
    authorize(@post || Post, policy_class: UserPostPolicy)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_current_user
    @user = User.find_by(id: current_user.id)
  end

  def post_params
    params.require(:post).permit(:body, images: []).merge(user_id: current_user.id)
  end
end
