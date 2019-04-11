class Journey

  MINIMUM_FARE = 3
  PENALTY_FARE = 6

  def initialize
    @journey = {}
  end

  def start_journey(station)
    @journey[:entry] = station
    return @journey
  end

  def end_journey(station)
    @journey[:exit] = station
    return @journey
  end

  def journey_complete?
    @journey.length == 2 ? true : false
  end

  def fare
    self.journey_complete? ? MINIMUM_FARE : PENALTY_FARE
  end

end
