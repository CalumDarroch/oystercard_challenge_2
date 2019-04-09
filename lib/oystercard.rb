class Oystercard

  BALANCE_LIMIT = 90
  BALANCE_MINIMUM = 1
  MINIMUM_CHARGE = 3

  attr_reader :balance
  attr_reader :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    fail "maximum limit = #{BALANCE_LIMIT}" if (@balance + amount) > BALANCE_LIMIT

    @balance += amount
  end

  def in_journey?
    if @entry_station == nil
      return false
    else
      return true
    end
  end

  def touch_in(station)
    fail "Balance below minimum" if @balance < BALANCE_MINIMUM
    @in_journey = true
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @in_journey = false
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
