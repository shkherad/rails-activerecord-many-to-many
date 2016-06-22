Rails.application.routes.draw do
  resources :endorsements, except: [:new, :edit]
  resources :skills, except: [:new, :edit]
  resources :jobs, except: [:new, :edit]
  resources :companies, except: [:new, :edit]
  resources :cities, except: [:new, :edit]
  resources :people, except: [:new, :edit]
end
