Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }


  resources :metrics

  get 'users/new_password', to: 'users#new_password', as: 'new_password'
  patch 'users/update_password', to: 'users#update_password', as: 'update_password'

  scope '/admin' do
    get '', to: 'admin#index', as: 'index'
    get 'users/new', to: 'admin#new_user', as: 'new_user'
    post 'users', to: 'admin#create_user', as: 'create_user'
    get 'users/:id', to: 'admin#show_user', as: 'show_user'
    get 'metrics/:id', to: 'admin#show_metric', as: 'show_metric'
    patch 'metrics/:id/update', to: 'admin#update_metric', as: 'update_metric'
    get 'statistics', to: 'admin#show_statistics', as: 'show_statistics'
    get 'statistics/cold', to: 'admin#show_cold_statistics', as: 'show_cold_statistics'
    get 'statistics/hot', to: 'admin#show_hot_statistics', as: 'show_hot_statistics'
  end

  root 'metrics#index'
end
