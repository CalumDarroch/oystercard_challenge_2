class Oystercard

  BALANCE_LIMIT = 90
  BALANCE_MINIMUM = 1
  MINIMUM_CHARGE = 3

  attr_reader :balance, :journey_history

  def initialize
    @balance = 0
    @journey = {}
    @journey_history = []
  end

  def top_up(amount)
    fail "maximum limit = #{BALANCE_LIMIT}" if (@balance + amount) > BALANCE_LIMIT
    @balance += amount
  end

  def in_journey?
    @journey.length == 1 ? true : false
  end

  def touch_in(station)
    fail "Balance below minimum" if @balance < BALANCE_MINIMUM
 #  @journey = Journey.new(entry: station)
    @journey = {}
    @journey[:entry] = station
    return @journey
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)  # move deduct to end of method, becomes deduct(journey.fare)
    @journey[:exit] = station
    @journey_history << @journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
