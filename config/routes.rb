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
    get 'users/:id', to: 'admin#show', as: 'user_detail'
    get 'metrics/:id/edit', to: 'admin#edit', as: 'admin_edit_metric'
    patch 'metrics/:id/edit', to: 'admin#update'
    get 'statistics', to: 'admin#show_statistics', as: 'show_statistics'
    get 'statistics/cold', to: 'admin#show_cold_statistics', as: 'show_cold_statistics'
    get 'statistics/hot', to: 'admin#show_hot_statistics', as: 'show_hot_statistics'
  end

  root 'metrics#index'
end
