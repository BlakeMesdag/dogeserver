require 'test_helper'

class WithdrawalTest < ActiveSupport::TestCase
  test 'creating a withdrawal' do
    withdrawal = large_account.withdrawals.new(to: "D6RQV3SfDgAZpQkM5kjjjaAFrFbsEyjN4t", amount: 10.123)

    assert withdrawal.save
    assert withdrawal.confirmation
  end

  test 'bad response from api should not create transactions' do
    FakeWeb.register_uri(:get, /.+dogeapi.+withdraw.+amount.+payment_address/, body: "Something bad happened")

    assert_no_difference "Transaction.count" do
      assert_no_difference "Withdrawal.count" do
        assert_raise DogeAPI::UnexpectedResponse do
          large_account.withdrawals.create!(to: "D6RQV3SfDgAZpQkM5kjjjaAFrFbsEyjN4t", amount: 9.23)
        end
      end
    end
  end

  test 'amount should be greater than 5' do
    withdrawal = large_account.withdrawals.new(to: "D6RQV3SfDgAZpQkM5kjjjaAFrFbsEyjN4t", amount: 4.999)

    refute withdrawal.save
    assert_equal ["Amount must be greater than or equal to 5"], withdrawal.errors.full_messages
  end

  test 'to address should be dogecoin wallet address length' do
    withdrawal = large_account.withdrawals.new(to: "fake-address", amount: 5)

    refute withdrawal.save
    assert_equal ["To is the wrong length (should be 34 characters)"], withdrawal.errors.full_messages
  end
end
