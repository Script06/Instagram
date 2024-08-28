class PostLikesController < ApplicationController
  before_action :find_post, only: %i[create destroy]
  def create
    user_liked_post?(current_user, @post) ? remove_like_flow : create_like_flow

    redirect_to root_path
  end

  private

  def remove_like_flow
    PostLike.find_by(user_id: current_user.id, post_id: @post.id)&.destroy
    @post.likes_count -= 1
    @post.save
  end

  def create_like_flow
    PostLike.create(user_id: current_user.id, post_id: @post.id)
    @post.likes_count += 1
    @post.save
  end

  def user_liked_post?(user, post)
    PostLike.exists?(user_id: user.id, post_id: post.id)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
