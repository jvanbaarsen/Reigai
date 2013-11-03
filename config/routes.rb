Reigai::Application.routes.draw do
  root 'dashboard#index'

  namespace 'api' do
    namespace 'v1' do
      post 'notify' => 'logs#create'
    end
  end


  get 'register' => 'users#new', as: 'register'
  post 'register' => 'users#create'

  get 'login' => 'sessions#new', as: 'login'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  # Application
  get 'application/new' => 'applications#new', as: 'create_application'
  post 'application/new' => 'applications#create'
  get 'application/:id' => 'applications#show', as: 'application'
end
