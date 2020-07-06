Rails.application.routes.draw do
  resources :tasks

  get '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'
end
