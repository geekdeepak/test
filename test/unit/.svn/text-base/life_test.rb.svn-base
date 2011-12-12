require 'test_helper'

class LifeTest < ActiveSupport::TestCase
  test "invalid fields" do
    life = Life.new
    assert !life.valid?
    assert life.errors.invalid?(:name)
  end
  
  test "unique name" do
    life = Life.new(:name => "Home", :user => users(:lenny))
    assert !life.valid?
    assert life.errors.invalid?(:name)
  end
  
  test "multiple projects" do
    life = lives(:home)
    assert_equal( 2, life.projects.count )
  end
  
  test "one project" do
    life = lives(:work)
    assert_equal( 1, life.projects.count )
  end
  
  test "creates life" do
    life = Life.new(:name => "Sport", :description => "Sports, ja?", :user => users(:john))
    assert life.valid?
    assert life.save!
  end
  
  test "update life" do
    life = lives(:work)
    old_name = life.name
    life.name = "New Job"
    assert_not_equal( old_name, life.name )
    old_description = life.description
    life.description = "I'm the boss now!"
    assert_not_equal( old_description, life.description )
  end
  
  test "delete life" do
    life = lives(:work)
    assert life.destroy
  end
end
