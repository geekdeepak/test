require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  test "routing" do
    assert_routing '/tasks', :controller => 'tasks', :action => 'index' 
    assert_routing '/tasks/today', :controller => 'tasks', :action => 'today'
    assert_routing '/tasks/tomorrow', :controller => 'tasks', :action => 'tomorrow'
    assert_routing '/tasks/overdue', :controller => 'tasks', :action => 'overdue'
    assert_routing '/tasks/new', :controller => 'tasks', :action => 'new'
    assert_routing '/tasks/1', :controller => 'tasks', :action => 'show', :id => '1'
    assert_routing '/tasks/1/edit', :controller => 'tasks', :action => 'edit', :id => '1'
  end
end
