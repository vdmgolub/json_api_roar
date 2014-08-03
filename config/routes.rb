Rails.application.routes.draw do
  resources :posts, only: [:index, :show]
  resources :authors, only: [:index, :show]
end
