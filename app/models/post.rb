class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :likes, class_name: 'PostLike', dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :body, length: { maximum: 1000 }, presence: true
  validates :images, presence: true
end
