class RenamePostsLikesToPostLikes < ActiveRecord::Migration[7.0]
  def change
    rename_table :posts_likes, :post_likes
  end
end
