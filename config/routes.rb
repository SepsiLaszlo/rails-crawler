Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'pulls', to: 'pull_requests#index'
  get 'pulls/:number', to: 'pull_requests#show', as: :pull
  root "pull_requests#index"
end
