Rails.application.routes.draw do
  root 'top#index'
  get 'about' => 'top#about', as: 'about'
  resources :members do
    collection { get 'search' }
  end
  resources :articles
  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update]
end
