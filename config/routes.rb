Rails.application.routes.draw do
  root 'pages#index'

  resources :participants

  get '/contact', to: 'pages#contact', as: :contact
end
