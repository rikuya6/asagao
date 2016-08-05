Rails.application.routes.draw do
  root 'top#index'
  get 'about' => 'top#about', as: 'about'
  resources :top, only: [:index]
  resources :members do
    collection { get 'search' }
  end
end
