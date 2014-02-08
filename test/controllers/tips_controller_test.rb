require 'test_helper'

class TipsControllerTest < ActionController::TestCase
  test "creating a tip" do
    expected_response = {
      "amount"    => "10.0",
      "to_name"   => small_account.name,
      "from_name" => large_account.name
    }

    post :create, account_name: large_account.name, key: large_account.key, tip: { to: small_account.name, amount: 10 }, format: :json

    assert_equal expected_response.to_json, response.body
    assert_response :created
  end

  test "creating a tip with incorrect key" do
    expected_response = { errors: "not found" }

    post :create, account_name: large_account.name, key: "hax", tip: { to: small_account.name, amount: 10 }, format: :json

    assert_equal expected_response.to_json, response.body
    assert_response :not_found
  end

  test "creating a tip to invalid address" do
    expected_response = { errors: "not found" }

    post :create, account_name: large_account.name, key: large_account.key, tip: { to: "invalid", amount: 10 }, format: :json

    assert_equal expected_response.to_json, response.body
    assert_response :not_found
  end
end
