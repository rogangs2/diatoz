Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  #session routes
  get 'subscriber/login', to: 'sessions#new'
  get 'author/login', to: 'sessions#new'
  delete '/sessions', to: 'sessions#destroy'
  resources :sessions, only: [:new, :create]

  resources :subscribers, only: [:new, :create]
  get 'subscriber/dashboard', to: 'subscriber_dashboard#show'
  post 'subscriber/block', to: 'subscribers#block_subscriber', as: 'block_subscriber'

  resources :authors
  get 'author/dashboard', to: 'author_dashboard#show'

  resources :blogs do
    resources :posts, only: [:new, :index, :create]
  end

  resources :posts do
    resources :comments
  end

  get '/commentsApproval', to: 'comments#comments_need_approval'
  post 'author/:author_id/comment/new', to: 'comments#comment_on_author'
end
