require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get home_search_url
    assert_response :success
  end

end
