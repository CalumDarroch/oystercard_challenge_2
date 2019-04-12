class Journey

  MINIMUM_FARE = 3
  PENALTY_FARE = 6

  attr_reader :journey

  def initialize(station)
    start_journey(station)
  end

  def start_journey(station)
    @journey = {}
    @journey[:entry] = station
    return @journey
  end

  def end_journey(station)
    @journey[:exit] = station
    return @journey
  end

  def journey_complete?
    @journey[:entry] != nil && @journey[:exit] != nil ? true : false
  end

  def fare
    self.journey_complete? ? MINIMUM_FARE : PENALTY_FARE
  end

end
