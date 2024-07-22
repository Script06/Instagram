class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  before_action :authorize_comment!, only: %i[edit update destroy]
  after_action :verify_authorized, only: %i[edit update destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_back(fallback_location: root_path, notice: 'Комментарий успешно создан.')
    else
      flash[:notice] = 'комментарий не создан, неизвестная ошибка'
    end
  end

  def destroy
    Comment.find(params[:id])&.destroy

    redirect_back(fallback_location: root_path)
    flash[:notice] = 'комментарий удалён'
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
