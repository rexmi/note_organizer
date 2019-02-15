Rails.application.routes.draw do
  root to: 'pages#index'
  resources :notes
  get 'test' => 'pages#testpage'
  get 'preview' => 'pages#preview'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
