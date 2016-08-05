Rails.application.routes.draw do
  root 'top#index'
  resources :top, except: [:new, :show, :create, :edit]
  get 'about' => 'top#about', as: 'about'
end
