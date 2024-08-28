class CommentsController < ApplicationController
  protect_from_forgery with: :exception
  before_action :set_comment, only: %i[edit update destroy]
  before_action :authorize_comment!, only: %i[edit update destroy]
  after_action :verify_authorized, only: %i[edit update destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    # TODO: дописать ответ в случае ошибки, прописать html?
    respond_to do |format|
      if @comment.save
        format.html { redirect_to posts_path, notice: 'Комментарий был успешно добавлен.' } # для HTML форм
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.js
        # format.html { redirect_to some_path, notice: 'Комментарий удален.' }
      end
    else
      format.js
    end
  end

  def update
    @comment.update(comment_params)
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
