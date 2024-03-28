Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'posts#index'

  resources :user_posts, only: %i[index new create update destroy edit]
  post 'like_post/:id', to: 'post_likes#like_post', as: 'like_post'
  get 'profiles/:username', to: 'profiles#index', as: :profile

  resources :subscriptions, only: %i[create destroy]
end
