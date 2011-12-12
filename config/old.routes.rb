ActionController::Routing::Routes.draw do |map|

  map.login "/login", :controller => "user_sessions", :action => "new"
  map.logout "/logout", :controller => "user_sessions", :action => "destroy"
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.reset_password '/reset_password', :controller => 'password_resets', :action => 'new'
  map.reset '/reset/:id', :controller => 'password_resets', :action => 'edit'
  map.activate '/activate/:id', :controller => 'activations', :action => 'create'
  map.confirm '/contacts/confirm/:id', :controller => 'contacts', :action => 'confirm'
  map.confirm_project '/projects/confirm/:id', :controller => 'projects', :action => 'confirm'
  
  map.move_task_higher '/tasks/:id/move_higher', :controller => 'tasks', :action => 'move_higher'
  map.move_task_lower '/tasks/:id/move_lower', :controller => 'tasks', :action => 'move_lower'
  
  map.project_user '/projects/:id/users/:user_id', :controller => 'projects', :action => 'show'
  map.life_user '/life/:id/users/:user_id', :controller => 'lives', :action => 'show'
  map.tasks_user '/tasks/users/:user_id', :controller => 'tasks', :action => 'show_user'
  
  map.show_life_profile '/lives/:life_id/profile', :controller => 'profiles', :action => 'show'
  
  tasks_collection = { :tomorrow => :get, :today => :get, :overdue => :get, :completed => :get, :undated => :get }
  
  map.resources :tasks, :collection => tasks_collection, :member => { :start => :get, :complete => :put, :pause => :put }
  
  map.resources :projects do |projects|
    projects.resources :tasks, :collection => tasks_collection
  end
  
  map.resources :users, :shallow => true do |users|
    users.resources :projects
    users.resources :tasks, :collection => tasks_collection
  end
  
  map.resources :lives do |lives|
    lives.resources :projects
    lives.resources :profiles
    lives.resources :contacts
    lives.resources :tasks, :collection => tasks_collection
  end
  
  map.resource :user_session
  map.resources :profiles
  map.resources :password_resets
  map.resources :contacts
  map.resources :messages
    
  map.root :projects
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end