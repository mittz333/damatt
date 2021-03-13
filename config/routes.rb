Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :members, controllers: { registrations: 'registrations' }
  resources :items do
    resources :lendings, only: [:create, :index, :destroy]
    resources :reservations, only: [:create, :index, :destroy]
    collection do
      get 'search'
    end
  end
  devise_scope :member do
    post 'members/guest_sign_in', to: 'members/sessions#new_guest'
  end
end