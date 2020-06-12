Rails.application.routes.draw do
  # get 'admin/index'
  # devise_for :admins
  devise_for :users
  resources :metrics
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'users/profile'

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
