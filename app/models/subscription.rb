class Subscription < ApplicationRecord
  belongs_to :follower, foreign_key: 'follower_id', class_name: 'User'
  belongs_to :following, foreign_key: 'following_id', class_name: 'User'

  # TODO: Валидация, существует ли подписка при создании. Если да, то что?
end
