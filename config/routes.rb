Rails.application.routes.draw do
  resources :skills, except: [:new, :edit]
  resources :companies, except: [:new, :edit]
  resources :cities, except: [:new, :edit]
  resources :people, except: [:new, :edit]
end
