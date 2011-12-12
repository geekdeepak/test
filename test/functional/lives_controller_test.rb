require 'test_helper'

class LivesControllerTest < ActionController::TestCase
  test "basic routing" do
    assert_routing '/lives', :controller => 'lives', :action => 'index' 
    assert_routing '/lives/new', :controller => 'lives', :action => 'new'
    assert_routing '/lives/1', :controller => 'lives', :action => 'show', :id => '1'
    assert_routing '/lives/1/edit', :controller => 'lives', :action => 'edit', :id => '1'
  end
  
  test "nested routing" do
    assert_routing '/lives/1/projects', :controller => 'projects', :action => 'index', :life_id => '1'
    assert_routing '/lives/1/tasks', :controller => 'tasks', :action => 'index', :life_id => '1'
    assert_routing '/lives/1/tasks/today', :controller => 'tasks', :action => 'today', :life_id => '1'
    assert_routing '/lives/1/tasks/tomorrow', :controller => 'tasks', :action => 'tomorrow', :life_id => '1'
    assert_routing '/lives/1/tasks/overdue', :controller => 'tasks', :action => 'overdue', :life_id => '1'
    assert_routing '/lives/1/tasks/new', :controller => 'tasks', :action => 'new', :life_id => '1'
  end
end
