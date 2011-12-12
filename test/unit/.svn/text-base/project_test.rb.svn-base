require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "invalid fields" do
    project = Project.new
    assert !project.valid?
    assert project.errors.invalid?(:name)
  end
  
  test "a life" do
    project = projects(:website)
    assert project.lives.count == 1
  end
  
  test "multiple lives" do
    project = projects(:dunfast)
    assert project.lives.count > 1
    assert project.lives.count == 2
    
    project = projects(:nuke)
    project.lives << lives(:home)
    assert project.lives.count > 1
    assert project.lives.count == 2
  end
  
  test "multiple tasks" do
    project = projects(:website)
    assert_equal( 8, project.tasks.count )
  end
  
  test "creates project" do
    project = Project.new(:name => "Christmas 2011")
    assert project.valid?
    assert project.save!
    project = Project.new(:name => "Leaving Party", :lives => [lives(:john_work)])
    assert project.valid?
    assert project.save!
  end
  
  test "update project" do
    project = projects(:website)
    old_name = project.name
    project.name = "Client X"
    assert_not_equal( old_name, project.name )
    old_description = project.description
    project.description = "Client X Website"
    assert_not_equal( old_description, project.description )
  end
  
  test "delete project" do
    project = projects(:website)
    assert project.destroy
  end
end
