Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static#home', as: 'root'

  post '/:short_url/auth', to: 'rooms#authenticate', as: 'authenticate'
  get '/:short_url', to: 'rooms#index', as: 'view_room'

  resources :rooms, only: [:create]

  resources :users, only: [:new, :create]
end
