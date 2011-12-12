require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "invalid fields" do
    user = User.new()
    assert !user.valid?
    assert user.errors.invalid?(:username)
    user.username = "meeeep"
    assert !user.valid?
    assert user.errors.invalid?(:email)
    user.username = "me"
    assert !user.valid?
    assert user.errors.invalid?(:email)
    user.username = "me@meep.com"
    assert !user.valid?
    assert user.errors.invalid?(:password)
    user.password = "meeeep"
    assert !user.valid?
    assert user.errors.invalid?(:password_confirmation)
  end
  
  test "creates user" do
    user = User.new(:username => "Frankie", :password => "Fishy", :password_confirmation => "Fishy", :email => "frankie@fishlovers.com")
    assert user.valid?
    assert user.save!
    assert !user.active?
    assert user.unauthorised?
  end
  
  test "delete user" do
    user = users(:steve)
    assert user.destroy
  end
  
  test "many lives" do
    user = users(:lenny)
    assert_not_nil user.lives
    assert user.has_life?
    assert_equal( 2, user.lives.count )
  end
  
  test "one life" do
    user = users(:carl)
    assert_not_nil user.lives
    assert user.has_life?
    assert_equal( 1, user.lives.count )
  end
  
  test "no life" do
    user = users(:steve)
    assert user.lives.empty?
    assert !user.has_life?
    assert_equal( 0, user.lives.count )
  end
  
  test "suicide" do
    user = users(:steve)
    assert !user.has_life?
    assert user.destroy
  end
  
  test "enable user" do
    user = users(:steve)
    assert !user.active?
    user.activate!
    assert user.active?
  end
  
  test "ban user" do
    user = users(:lenny)
    assert user.active?
    user.ban!
    assert !user.active?
    assert user.banned?
    users = User.enabled
    assert_equal( 1, users.count )
  end
  
  test "authorised users" do
    users = User.enabled
    assert_equal( 2, users.count )
  end
end
