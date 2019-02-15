Rails.application.routes.draw do
  devise_for :users
  get 'messages/index'
  root 'homes#index'

  resources :messages do
    collection do
      get 'chat'
      get 'change_chat'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
