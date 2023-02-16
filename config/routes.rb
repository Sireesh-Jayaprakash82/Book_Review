Rails.application.routes.draw do
  devise_for :users 
  resources :books, shallow: true do 
  resources :comments, shallow: true
  end
  get '/review', to: 'comments#review'
root 'books#index'
end
  