Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  get 'users/new_password', to: 'users/password#new_password', as: 'new_password'
  patch 'users/update_password', to: 'users/password#update_password', as: 'update_password'

  resources :metrics

  scope module: 'admin', path: 'admin' do
    get '', to: 'users#index', as: 'index'

    get 'metrics/edit/:id', to: 'metrics#edit', as: 'show_metric'
    patch 'metrics/edit/:id/update', to: 'metrics#update', as: 'update_metric'

    get 'statistics', to: 'statistics#index', as: 'show_statistics'
    get 'statistics/cold', to: 'statistics#cold', as: 'show_cold_statistics'
    get 'statistics/hot', to: 'statistics#hot', as: 'show_hot_statistics'

    get 'users/new', to: 'users#new', as: 'new_user'
    post 'users/create', to: 'users#create', as: 'create_user'
    get 'users/:id', to: 'users#show', as: 'show_user'
  end

  root 'metrics#index'
end
