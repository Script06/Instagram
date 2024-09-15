# frozen_string_literal: true

class CommentsController < ApplicationController
  protect_from_forgery with: :exception
  before_action :set_comment, only: %i[edit destroy]
  before_action :authorize_comment!, only: %i[edit destroy]
  after_action :verify_authorized, only: %i[edit destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to posts_path, notice: t('.success_comment') }
        format.js
      else
        format.html { redirect_to posts_path, notice: t('.error_comment') }
        format.js
      end
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.js
        format.html { redirect_to posts_path, notice: t('.success_destroy_comment') }
      end
    else
      format.js
      format.html { redirect_to posts_path, notice: t('.error_destroy_comment') }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_comment!
    authorize(@comment || Comment, policy_class: CommentPolicy)
  end

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end
end
