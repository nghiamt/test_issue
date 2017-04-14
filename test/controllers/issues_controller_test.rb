require 'test_helper'

class IssuesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get hook" do
    get :hook
    assert_response :success
  end

end
