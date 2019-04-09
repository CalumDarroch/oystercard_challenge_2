class Oystercard

  BALANCE_LIMIT = 90
  BALANCE_MINIMUM = 1

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

  def touch_in
    fail "Balance below minimum" if @balance < BALANCE_MINIMUM
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
