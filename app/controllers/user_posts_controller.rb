class UserPostsController < ApplicationController
  before_action :set_post, only: %i[edit destroy]
  def index
    @posts = Post.where(user_id: current_user.id)
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

  def set_post
    @post = Post.find(params[:id])
  end
end
