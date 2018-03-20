Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  resources :text_messages
  resources :messages
  root to: 'messages#index'
end
