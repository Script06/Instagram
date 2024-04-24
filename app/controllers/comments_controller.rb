class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  before_action :authorize_comment!, only: %i[edit update destroy]
  after_action :verify_authorized, only: %i[edit update destroy]

  def create
    Comment.create(comment_params)

    redirect_back(fallback_location: root_path)
  end

  def destroy
    Comment.find(params[:id])&.destroy

    redirect_back(fallback_location: root_path)
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
