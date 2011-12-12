require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "basic routing" do
    assert_routing '/users', :controller => 'users', :action => 'index' 
    assert_routing '/signup', :controller => 'users', :action => 'new'
    assert_routing '/users/1', :controller => 'users', :action => 'show', :id => '1'
    assert_routing '/users/1/edit', :controller => 'users', :action => 'edit', :id => '1'
  end
  
  test "nested routing" do
    assert_routing '/users/1/projects', :controller => 'projects', :action => 'index', :user_id => '1'
    assert_routing '/users/1/tasks', :controller => 'tasks', :action => 'index', :user_id => '1'
    assert_routing '/users/1/tasks/today', :controller => 'tasks', :action => 'today', :user_id => '1'
    assert_routing '/users/1/tasks/tomorrow', :controller => 'tasks', :action => 'tomorrow', :user_id => '1'
    assert_routing '/users/1/tasks/overdue', :controller => 'tasks', :action => 'overdue', :user_id => '1'
    assert_routing '/users/1/tasks/new', :controller => 'tasks', :action => 'new', :user_id => '1'
  end
end
