Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'main#index'

  # API
  namespace :api do #, defaults: { format: :json } do
    resources :contextio, only: [:create]
  end

end
