Rails.application.routes.draw do
  resources :users, only: %i[new create]
  resources :session, only: %i[new create destroy]
  resources :goals, only: %i[index new create show edit update destroy]
end
