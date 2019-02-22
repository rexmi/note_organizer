Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#index'
  resources :notes
  get 'test' => 'pages#testpage'
  get 'preview' => 'pages#preview'
  get 'search' => 'notes#search'
  get '/users' => 'pages#index', as: :user_root
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
