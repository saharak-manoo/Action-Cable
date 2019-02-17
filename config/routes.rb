Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'messages/index'
  root 'homes#index'

  resources :homes do
    collection do
      get 'new_feed'
      get 'comment'
    end
  end

  resources :messages do
    collection do
      get 'chat'
      get 'change_chat'
      get 'search'
    end
  end

  Rails.application.routes.draw do
    devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
