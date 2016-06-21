Rails.application.routes.draw do
  resources :cities, except: [:new, :edit]
  resources :people, except: [:new, :edit]
end
