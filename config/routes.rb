Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  resources :charges
  resources :activities, only: [:show] do
    resources :activity_tickets, only: [:new, :create, :destroy]
    resources :chatrooms
  end

  resources :services, only: [:show] do
    resources :service_tickets, only: [:new, :create, :destroy]
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
  delete '/stripe/:user_id/delete_stripe_acct', to: "stripe_connect_customs#delete_stripe_acct"
  # get "/stripe/:user_id/update_stripe_acct_details", to: "stripe_connect_customs#update_stripe_acct_details"
  # post "/stripe/:user_id/update_stripe_acct_details", to: "stripe_connect_customs#create_update_stripe_acct_details"
  get '/stripe/:user_id/stripe_acct', to: "stripe_connect_customs#stripe_acct"
  get '/activities', to: 'static_pages#activities'
  get '/users/activation_reminder', to: "users#activation_reminder"
  get '/users/activate_account/:activation_id', to: 'users#activate_account'
  post '/users/activate_account/:activation_id', to: 'users#create_activate_account'
  get '/activities/:activity_id/spots', to: 'activity_tickets#spots'
  post '/activities/:activity_id/spots', to: 'activity_tickets#create_spots'
  post '/rentals/:rental_id/days_renting', to: 'rental_tickets#create_days_renting'
  get '/rentals/:rental_id/days_renting', to: 'rental_tickets#days_renting'
  root "static_pages#home"
  get "/categories/:id/testing", to: "categories#show_testing"
  get "/home/testing", to: "static_pages#home"
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
  get '/users/:id/updatePassword', to: 'users#update_password'
  post '/users/:id/updatePassword', to: 'users#create_update_password'
  post '/users/resetPasswordLink', to: 'users#create_reset_password_link'
  get '/users/resetPasswordLink', to: 'users#reset_password_link'
  post '/users/:id/resetPassword', to: 'users#create_reset_password'
  get '/users/:id/resetPassword', to: 'users#reset_password'
  get '/users/resetPasswordNotification', to: "users#reset_password_notification"
  get '/email_users', to: 'static_pages#email_users'
  get '/categories/services', to: "categories#services_index"
  get '/categories/:id/services', to: "categories#show_services"
  get '/users/:user_id/calendars', to: 'calendars#show'
  get '/users/:user_id/months/:month_id/days/:day_id', to: 'days#show'
  post '/users/:user_id/months/:month_id/days/:day_id', to: 'days#create'
  get '/users/:user_id/calendars/appointments', to: 'calendars#show_appointments'
  delete '/users/:user_id/appointments/:appointment_id', to: "days#destroy"
  post '/users/:user_id/appointments/:appointment_id/book', to: "days#book_appointment"
  get '/users/:user_id/inbox', to: 'users#inbox'
  get '/demo_login', to: 'static_pages#special_login'
  get '/how_it_works/one', to: "static_pages#how_one"
  get '/how_it_works/two', to: "static_pages#how_two"
  get '/how_it_works/three', to: "static_pages#how_three"


  resources :users
  resources :account_activations, only: [:edit]
  resources :categories, only: [:index, :show]
  resources :rentals, only: [:create, :edit, :update, :index, :destroy, :show]
  resources :activities, only: [:new, :show, :edit, :update, :create, :destroy]
  resources :services, only: [:new, :show, :edit, :update, :create, :destroy]

  namespace :api, defaults: {format: :json} do
    resource :session, only: [:create, :destroy]
    resources :users, only: [:show, :create]
    resources :activities, only: [:index, :show, :create]
    resources :categories, only: [:index, :show]
    resources :activities do
      resources :activity_tickets, only: [:create]
    end

    post "/stripe/:user_id/create", to: "stripes#create_stripe_account"
    post "/stripe/:user_id/terms/create", to: "stripes#create_agree_stripe_terms"
    post "/stripe/:user_id/stripe_acct_details", to: "stripes#stripe_acct_details_create"
    delete '/stripe/:user_id/delete_stripe_acct', to: "stripes#delete_stripe_acct"
    # post '/activities/:id/activity_tickets', to: 'activity_tickets#create'
  end

  mount ActionCable.server => '/cable'

  resources :chatrooms, param: :slug
  resources :messages
  resources :user_chatrooms
  resources :user_messages


end
