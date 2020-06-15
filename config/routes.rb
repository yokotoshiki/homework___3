Rails.application.routes.draw do
    root 'homes#top'
    root to: 'homes#top'
    get 'home/about' => 'homes#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
    resources :books
    resources :users, only: [:show, :edit, :update, :index]
end
