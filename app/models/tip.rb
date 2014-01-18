class Tip
  def initialize(from, to, amount)
    @from   = from
    @to     = to
    @amount = amount
  end

  def self.create(from, to, amount)
    tip = new(from, to, amount)
    tip.complete
    tip
  end

  def complete
    ActiveRecord::Base.transaction do
      @from.transactions.create!(amount: @amount * -1)
      @to.transactions.create!(amount: @amount)
    end
  end
end