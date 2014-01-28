require 'test_helper'

class WithdrawalsControllerTest < ActionController::TestCase
  test "creating a withdrawal" do
    post :create, withdrawal: { to: "DK8b3CgQRwFC58PpcerneMR15WYiYKjU2G", amount: 17.234 }, account_name: small_account.name, key: small_account.key, format: :json

    assert_response :created
  end
end
