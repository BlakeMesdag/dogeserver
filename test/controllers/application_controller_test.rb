require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  test 'ping' do
    get :ping

    assert_response :success
  end
end