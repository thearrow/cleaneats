Cleaneats::Application.routes.draw do
  resources :places do
    get 'search', on: :collection
  end

  root :to => "home#index"
end
