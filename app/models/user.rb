class User < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  has_many :follower_relationships, dependent: :destroy, foreign_key: :following_id, class_name: 'Subscription'
  has_many :followers, through: :follower_relationships, source: :follower, dependent: :destroy

  has_many :following_relationships, dependent: :destroy, foreign_key: :follower_id, class_name: 'Subscription'
  has_many :following, through: :following_relationships, source: :following

  has_many :comments, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false }

  def following?(other_user)
    following.exists?(other_user.id)
  end
end
