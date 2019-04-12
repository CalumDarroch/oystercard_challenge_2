require_relative "journey"

class Oystercard

  BALANCE_LIMIT = 90
  BALANCE_MINIMUM = 1

  attr_reader :balance, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    fail "Maximum balance = #{BALANCE_LIMIT}" if (@balance + amount) > BALANCE_LIMIT
    @balance += amount
  end

  # def in_journey?
  #   @journey.length == 1 ? true : false
  # end

# journey now going to be a hash of hashes?
# e.g. journey = {entry: {station: "x", zone: 1}, exit: {station: "y", zone: 5} }

  def touch_in(station)
    fail "Balance below minimum" if @balance < BALANCE_MINIMUM
    @journey = Journey.new(station)
    return @journey
  end

  def touch_out(station)
    @journey.end_journey(station)
    deduct(@journey.fare)
    @journey_history << @journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
