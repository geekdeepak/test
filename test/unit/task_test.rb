require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "invalid fields" do
    task = Task.create
    assert !task.valid?
    assert task.errors.invalid?(:name)
  end
  
  test "creates task" do
    task = Task.create(:name => "Test Task", :description => "A Test Task", :due => 5.minutes.from_now, :lives => [lives(:work)], :project => projects(:car))
    assert task.valid?
    assert task.save!
  end
  
  test "update task" do
    task = tasks(:date)
    old_name = task.name
    task.name = "Big movie date"
    assert_not_equal( old_name, task.name )
    old_description = task.description
    task.description = "With the other woman"
    assert_not_equal( old_description, task.description )
    old_due = task.due
    task.due = Time.parse("20:30")
    assert_not_equal( old_due, task.due )
  end
  
  test "delete task" do
    task = tasks(:date)
    assert task.destroy
  end
  
  test "complete task" do
    task = tasks(:date)
    old_state = task.state
    task.complete!
    assert_not_equal( old_state, task.state )
    assert task.completed?
  end
  
  test "postpone task" do
    task = tasks(:client_meeting)
    old_due = task.due
    task.postpone!("30 minutes")
    assert_equal( old_due+30.minutes, task.due )
    old_due = task.due
    task.postpone!("30 hours")
    assert_equal( old_due+30.hours, task.due )
    old_due = task.due
    task.postpone!("30 days")
    assert_equal( old_due+30.days, task.due )
    task = tasks(:raise)
    old_due = task.due
    task.postpone!("1m")
    assert_equal( old_due+1.minute, task.due )
    old_due = task.due
    task.postpone!("1h")
    assert_equal( old_due+1.hour, task.due )
    old_due = task.due
    task.postpone!("1d")
    assert_equal( old_due+1.day, task.due )
  end
  
  test "incomplete tasks" do
    tasks = Task.incomplete
    assert_equal( 9, tasks.count )
  end
  
  test "todays tasks" do
    user = users(:lenny)
    tasks = []
    user.lives.each do |life|
      life.projects.each do |project|
        tasks += project.tasks.today
      end
    end
    assert_equal( 3, tasks.count )
    assert tasks.include?( tasks(:date) )
  end
  
  test "tomorrows tasks" do
    tasks = Task.tomorrow
    assert_equal( 3, tasks.count )
    assert tasks.include?( tasks(:bomber) )
  end
end
