Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  resources :metrics
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'users/profile'
  root 'metrics#index'
end
