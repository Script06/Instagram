class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # написать валидацию на текст комментария
end
