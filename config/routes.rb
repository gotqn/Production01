Rails.application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks' }

  scope "(:locale)", locale: /en|bg/ do
    #root to: 'welcome#index'

    mount Ckeditor::Engine => '/ckeditor'

    resources :articles

    scope '/admin' do
      resources :users
    end

    match '/contacts', to: 'contacts#new', via: 'get'
    resources 'contacts', only: [:new, :create]

    get '/pages/:page' => 'pages#show', as: :pages

    root 'pages#show', page: 'home'

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
