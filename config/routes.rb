Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :members
  resources :items
end
