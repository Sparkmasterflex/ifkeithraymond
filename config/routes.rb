Ifkeith::Application.routes.draw do
#  match '/:controller(/:action(/:page))'
  root :to => 'webpages#show'
  match '/login' => 'user_sessions#new', :as => :login, :via => :get
  match '/login' => 'user_sessions#create', :as => :login, :via => :post
  match '/logout' => 'user_sessions#destroy', :as => :logout
  match '/editor/' => 'webpages#dashboard', :as => :dashboard
  match '/projects' => 'projects#all_projects', :as => :all_projects
  match '/blogs' => 'blogs#all_blogs', :as => :all_blogs
  

  resources :users, :path => '/users'
  resources :contacts, :path => '/editor/contacts'

  resources :webpages, :path => '/editor/webpages' do
    collection do
      post :send_email
    end
    resources :subpages do
      collection do
        get :subpages_preview
      end
    end
  end

  resources :projects, :path => '/editor/projects'
  match '/projects/:id' => 'projects#show', :as => :project_show

  resources :features do
    collection do
      put :attach_image
    end
  end

  resources :blogs, :path => '/editor/blogs'
  match '/blogs/:id' => 'blogs#show',       :as => :blog_show

  resources :images, :only => :destroy do
    member do
      put :update_status
      put :order
    end
  end

  match '/:page_alias' => 'webpages#show',  :as => :show
end
