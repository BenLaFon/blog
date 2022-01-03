Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "posts#index"
  resources :posts do
    resources :comments, only: [:new, :create]
  end
  resources :comments, only: [:destroy, :edit, :update]
end
