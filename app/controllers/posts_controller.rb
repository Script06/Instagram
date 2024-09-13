class PostsController < ApplicationController
  # для вывода ленты абсолютно всех постов.
  # OPTIMIZE: при расширении сайт потребует пагинации
  # и постепенной отдачи постов во избежание "тяжелых запросов"
  def index
    @posts = Post.all
  end
end
