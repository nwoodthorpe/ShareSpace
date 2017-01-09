Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static#home'

  resources :rooms, only: [:new]

  resources :users, only: [:new, :create]
end
