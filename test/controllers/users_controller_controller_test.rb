require 'test_helper'

class UsersControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_controller_new_url
    assert_response :success
  end

  test "should get show" do
    get users_controller_show_url
    assert_response :success
  end

end
