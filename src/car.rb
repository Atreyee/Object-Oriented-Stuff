class Car

  attr_accessor :location

  def park(location)
    raise 'Car already parked!' if parked?
    @location = location
  end

  def retrieve
    raise 'Car not parked!' if !parked?
    @location = ""
  end

  def parked?
    @location && !@location.empty?
  end
end
