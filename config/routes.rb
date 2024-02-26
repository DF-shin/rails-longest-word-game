Rails.application.routes.draw do
  get 'new', to: 'pages#new'
  post 'score', to: 'pages#score'
end
