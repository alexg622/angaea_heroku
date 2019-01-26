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
  get "/stripe/:user_id/new", to: "stripe_connect_customs#new_stripe_account"
  post "/stripe/:user_id/create", to: "stripe_connect_customs#create_stripe_account"
  get "/stripe/:user_id/terms/new", to: "stripe_connect_customs#new_agree_stripe_terms"
  post "/stripe/:user_id/terms/create", to: "stripe_connect_customs#create_agree_stripe_terms"
  get '/stripe/:user_id/stripe_acct_details', to: "stripe_connect_customs#new_stripe_acct_details"
  post "/stripe/:user_id/stripe_acct_details", to: "stripe_connect_customs#stripe_acct_details_create"
  get '/activities', to: 'static_pages#activities'
  get '/users/activation_reminder', to: "users#activation_reminder"
  get '/users/activate_account/:activation_id', to: 'users#activate_account'
  post '/users/activate_account/:activation_id', to: 'users#create_activate_account'
  get '/activities/:activity_id/spots', to: 'activity_tickets#spots'
  post '/activities/:activity_id/spots', to: 'activity_tickets#create_spots'
  post '/rentals/:rental_id/days_renting', to: 'rental_tickets#create_days_renting'
  get '/rentals/:rental_id/days_renting', to: 'rental_tickets#days_renting'
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
