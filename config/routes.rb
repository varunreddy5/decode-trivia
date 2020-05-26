Rails.application.routes.draw do
  devise_for :users
  resources :questions, only: [:new, :create, :show, :index, :edit, :update] do
    member do
      post :check_answer
    end

    member do
      put 'upvote' => 'questions#upvote'
      put 'downvote' => "questions#downvote"
    end
  end
  root 'tags#index'
  get "/get-questions", to: "questions#get_questions"
  resources :tags, only: [:create, :index]
  resources :user_stats, only: [:index]
  resources :tag_scores, only: [:index]
  resources :attempted_questions, only: [:index]
end
