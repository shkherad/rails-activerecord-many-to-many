Rails.application.routes.draw do
  root 'albums#index'

  resources :albums do
    resources :songs
  end


end
