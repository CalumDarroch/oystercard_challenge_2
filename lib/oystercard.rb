class Oystercard

  BALANCE_LIMIT = 90
  BALANCE_MINIMUM = 1
  MINIMUM_CHARGE = 3

  attr_reader :balance, :entry_station, :journey_history

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey_history = {}
  end

  def top_up(amount)
    fail "maximum limit = #{BALANCE_LIMIT}" if (@balance + amount) > BALANCE_LIMIT
    @balance += amount
  end

  def in_journey?
    @entry_station == nil ? false : true
  end

  def touch_in(station)
    fail "Balance below minimum" if @balance < BALANCE_MINIMUM
    @exit_station = nil
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
    @exit_station = station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
