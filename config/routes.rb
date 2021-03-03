Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :members, controllers: { registrations: 'registrations' }
  resources :items do
    resources :lendings, only: [:create, :index, :destroy]
    resources :reservations, only: [:create, :index, :destroy]
  end
end