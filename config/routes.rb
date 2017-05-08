Rails.application.routes.draw do
  root 'pages#index'

  resources :participants

  get 'admin', to: 'participants#index', as: 'admin'

  get 'participants/:id/page_2', to: 'participants#edit_page_2', as: 'page_2'
  get 'participants/:id/page_3', to: 'participants#edit_page_3', as: 'page_3'

  get '/contact', to: 'pages#contact', as: :contact
end
