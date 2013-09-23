Cleaneats::Application.routes.draw do
  root :to => "home#index"

  resources :places do
    get 'search', on: :collection
  end
  put 'places/:id/rate', to: 'places#rate'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
end
