Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'posts#index'

  resources :posts
  resources :user_posts, only: %i[index destroy edit]
end
