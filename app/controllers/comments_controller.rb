# frozen_string_literal: true

class CommentsController < ApplicationController
  protect_from_forgery with: :exception
  before_action :set_comment, only: %i[edit destroy]
  before_action :authorize_comment!, only: %i[edit destroy]
  after_action :verify_authorized, only: %i[edit destroy]

  SUCCESS_COMMENT = "Комментарий был успешно добавлен!"
  ERROR_COMMENT = "Комментарий не был добавлен. Что-то пошло не так"
  SUCCESS_DESTROY_COMMENT = "Комментарий успешно удален!"
  ERROR_DESTROY_COMMENT = "Комментарий не был удален! Произошла ошибка"

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to posts_path, notice: SUCCESS_COMMENT }
        format.js
      else
        format.html { redirect_to posts_path, notice: ERROR_COMMENT }
        format.js
      end
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.js
        format.html { redirect_to posts_path, notice: SUCCESS_DESTROY_COMMENT }
      end
    else
      format.js
      format.html { redirect_to posts_path, notice: ERROR_DESTROY_COMMENT }
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
