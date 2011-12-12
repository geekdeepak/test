require 'test_helper'

class ProfileTest < ActiveSupport::TestCase

  test "New Profile" do
    profile = Profile.new
    assert profile.valid?
  end
  
  test "Full Name" do
    profile = profiles(:lenny_work)
    assert_equal( profile.name, "Leonard Red" )
    
    profile = profiles(:carl_home)
    assert_equal( profile.name, "carl" )
  end
  
  test "Full Address" do
    profile = profiles(:carl_home)
    assert_equal( profile.address, "Shire" )
    profile.address_1 = "A House"
    profile.address_2 = "A Street"
    assert_equal( profile.address, "A House,<br />A Street,<br />Shire" )
  end

end
