Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  resources :charges
  resources :activities, only: [:show] do
    resources :activity_tickets, only: [:new, :create, :destroy]
  end

  resources :rentals, only: [:show] do
    resources :rental_tickets, only: [:new, :create, :destroy]
  end
  # resources :activities
  # root 'static_pages#activities'  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/activities', to: 'static_pages#activities'
  root 'static_pages#home'
  get '/bookings' , to: 'static_pages#bookings'
  get '/dashboard' , to: 'static_pages#dashboard'
  get '/portfolio' , to: 'static_pages#portfolio'
  get '/settings' , to: 'static_pages#settings'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/showTermsConditions', to: 'static_pages#show_terms_and_conditions'
  get '/showPrivacyAgreement', to: 'static_pages#show_privacy_agreement'
  post '/termsConditions', to: "static_pages#create_terms_and_conditions"
  post '/privacyConditions', to: "static_pages#create_privacy_conditions"
  get '/termsConditions', to: 'static_pages#terms_and_conditions'
  get '/privacyConditions', to: 'static_pages#privacy_conditions'



resources :users
resources :account_activations, only: [:edit]
resources :categories, only: [:show]
resources :rentals, only: [:create, :edit, :update, :index, :destroy, :show]
resources :activities, only: [:new, :show, :edit, :update, :create, :destroy]
end
