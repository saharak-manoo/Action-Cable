Rails.application.routes.draw do
  get 'pages/index'

  resources :pages do
    collection do
      get 'chat'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
