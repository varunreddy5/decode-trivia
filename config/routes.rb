Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:"welcome#index"
  resources :questions, only: [:new, :create, :show, :index, :edit] do
    member do
      post :check_answer
      
    end
  end
  get "/get-questions", to: "questions#get_questions"
  resources :tags, only: [:create, :index]
  resources :user_stats, only: [:index]
end
