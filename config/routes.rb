Rails.application.routes.draw do
  root to: 'pages#index'
  resources :notes
  get 'test' => 'pages#testpage'
  get 'preview' => 'pages#preview'
  get 'search' => 'notes#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
