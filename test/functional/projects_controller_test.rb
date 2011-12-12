require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  test "basic routing" do
    assert_routing '/projects', :controller => 'projects', :action => 'index' 
    assert_routing '/projects/new', :controller => 'projects', :action => 'new'
    assert_routing '/projects/1', :controller => 'projects', :action => 'show', :id => '1'
    assert_routing '/projects/1/edit', :controller => 'projects', :action => 'edit', :id => '1'
  end
  
  test "nested routing" do
    assert_routing '/projects/1/tasks', :controller => 'tasks', :action => 'index', :project_id => '1'
    assert_routing '/projects/1/tasks/today', :controller => 'tasks', :action => 'today', :project_id => '1'
    assert_routing '/projects/1/tasks/tomorrow', :controller => 'tasks', :action => 'tomorrow', :project_id => '1'
    assert_routing '/projects/1/tasks/overdue', :controller => 'tasks', :action => 'overdue', :project_id => '1'
    assert_routing '/projects/1/tasks/new', :controller => 'tasks', :action => 'new', :project_id => '1'
  end
end
