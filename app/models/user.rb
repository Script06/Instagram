class User < ApplicationRecord
  has_many :subscriptions, foreign_key: :follower_id
  has_many :subscribers, through: :subscriptions, source: :following, class_name: 'User'

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
    subscribers.exists?(other_user.id)
  end
end
