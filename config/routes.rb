Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :members
  resources :items do
    resources :lendings, only: [:create, :index, :destroy]
  end
end
