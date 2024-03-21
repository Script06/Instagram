class PostLikesController < ApplicationController
  def like_post
    @post = Post.find(params[:id])
    if user_liked_post?(current_user, @post)
      PostLike.find_by(user_id: current_user.id, post_id: @post.id)&.destroy
      @post.likes_count -= 1
      @post.save
    else
      PostLike.create(user_id: current_user.id, post_id: @post.id)
      @post.likes_count += 1
      @post.save
    end
    redirect_to root_path
  end

  private

  def user_liked_post?(user, post)
    PostLike.exists?(user_id: user.id, post_id: post.id)
  end
end
