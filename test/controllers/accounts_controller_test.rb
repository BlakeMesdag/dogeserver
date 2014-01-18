require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  test 'show account' do
    get :show, name: small_account.name, key: small_account.key, format: :json

    assert_equal small_account.to_json(methods: :balance), response.body
    assert_response :success
  end

  test 'create account' do
    post :create, account: { name: "new-account", key: "secret" }, format: :json

    assert_equal assigns(:account).to_json, response.body
    assert_response :created
  end
end
