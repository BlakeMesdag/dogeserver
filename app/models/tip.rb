class Tip
  attr_reader :errors, :from, :to, :amount

  def initialize(from, to, amount)
    @from   = from
    @to     = to
    @amount = amount
    @errors = []
  end

  def self.create(from, to, amount)
    tip = new(from, to, amount)
    tip.complete
    tip
  end

  def complete
    ActiveRecord::Base.transaction do
      @from_transaction = @from.transactions.create!(amount: @amount * -1)
      @to_transaction   = @to.transactions.create!(amount: @amount)
    end
  rescue
    @errors = { tip:  "Failed to create tip" }
  end

  def has_errors?
    @errors || false
  end

  def read_attribute_for_serialization(a)
    send(a)
  end
end
