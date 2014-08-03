Rails.application.routes.draw do
  resources :posts, only: [:index, :show]
  resources :authors, only: [:index, :show] do
    get :posts, to: 'author_posts#index'
  end
end
