require 'test_helper'

class TipsControllerTest < ActionController::TestCase
  test "creating a tip" do
    expected_response = {
      "from" => {
        "name" => "unicorn-user-1"
      },
      "to" => {
        "name" => "unicorn-user-136"
      },
      "amount" => 10
    }

    from_params = { name: large_account.name, key: large_account.key }
    to_params   = { name: small_account.name }
    amount      = 10

    post :create, from: from_params, to: to_params, amount: amount, format: :json

    assert_equal expected_response.to_json, response.body
    assert_response :created
  end

  test "creating a tip with incorrect key" do
    expected_response = { errors: { tip: "Failed to create tip" } }

    from_params = { name: large_account.name, key: "hax" }
    to_params   = { name: small_account.name }
    amount      = 10

    post :create, from: from_params, to: to_params, amount: amount, format: :json

    assert_equal expected_response.to_json, response.body
    assert_response :unprocessable_entity
  end

  test "creating a tip to invalid address" do
    expected_response = { errors: { tip: "Failed to create tip" } }

    from_params = { name: large_account.name, key: large_account.key }
    to_params   = { name: "invalid" }
    amount      = 10

    post :create, from: from_params, to: to_params, amount: amount, format: :json

    assert_equal expected_response.to_json, response.body
    assert_response :unprocessable_entity
  end

  test "creating a tip for more than the sender's account has" do
    expected_response = { errors: { tip: "Failed to create tip" } }

    from_params = { name: large_account.name, key: large_account.key }
    to_params   = { name: small_account.name }
    amount      = 9000

    post :create, from: from_params, to: to_params, amount: amount, format: :json

    assert_equal expected_response.to_json, response.body
    assert_response :unprocessable_entity
  end
end
