Cleaneats::Application.routes.draw do
  resources :places

  root :to => "home#index"
end
