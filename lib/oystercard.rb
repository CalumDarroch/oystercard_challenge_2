class Oystercard

  BALANCE_LIMIT = 90

  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "maximum limit = #{BALANCE_LIMIT}" if (@balance + amount) > BALANCE_LIMIT

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    return @in_journey
  end

end
