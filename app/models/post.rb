class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :likes, class_name: 'PostLike', dependent: :destroy
  has_many :comments
end
