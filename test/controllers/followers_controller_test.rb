require 'test_helper'

class FollowersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get followers_show_url
    assert_response :success
  end

end
