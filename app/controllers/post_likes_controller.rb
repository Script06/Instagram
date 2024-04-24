class PostLikesController < ApplicationController
  before_action :find_post, only: %i[create destroy]
  before_action :find_like, only: %i[destroy]

  def create
    if already_liked?
      flash[:notice] = 'Вы не можете лайкнуть запись больше одного раза!'
    else
      @post.likes.create(user_id: current_user.id)
      @post.likes_count += 1
      @post.save
    end

    redirect_to root_path
  end

  def destroy
    if !already_liked?
      flash[:notice] = 'Нельзя ставить дизлайк, если не стоит лайк, мамкин хацкер'
    else
      @like.destroy
      @post.likes_count -= 1
      @post.save
    end

    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_like
    @like = @post.likes.find(params[:id])
  end

  def already_liked?
    PostLike.where(user_id: current_user.id, post_id: params[:post_id]).exists?
  end
end
