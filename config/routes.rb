Rails.application.routes.draw do
  root 'pages#index'

  get '/contact', to: 'pages#contact', as: :contact
end
