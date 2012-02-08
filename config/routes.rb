SpreaderBeta::Application.routes.draw do

  resources :facebooks
  root :to => "home#index"

  devise_for :users #, :controllers => { :registrations => "registrations" }
  resources :users, :only => :show

  #replace these after demo
  match '/dashboard/:id' => 'dashboard#graph'

  match '/dashboard' => 'dashboard#index'
  match '/features' => 'features#index'
  match '/tutorials' => 'tutorials#index'
  match '/faq' => 'faq#index'
  match '/pricing' => 'pricing#index'
  match '/terms' => 'terms#index'
  match '/about' => 'about#index'
  match '/privacy' => 'privacy#index'

end
