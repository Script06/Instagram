class RemovePhotoFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :photo
  end
end
