require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  test 'show account' do
    expected_json = {name: "unicorn-user-136", deposited: "0.0", balance: "100.0", total_pending_sent_tips: "1.0", available_balance: "99.0"}

    get :show, name: small_account.name, key: small_account.key, format: :json

    assert_equal expected_json.to_json, response.body
    assert_response :success
  end

  test 'create account' do
    post :create, account: { name: "new-account", key: "secret" }, format: :json

    assert_equal assigns(:account).to_json, response.body
    assert_response :created
  end
end
