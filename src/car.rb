class Car

  attr_reader :garage
  def park(garage)
    raise 'Car already parked!' if parked?
    @garage = garage
    @garage.add_car(self)
  end

  def retrieve
    raise 'Car not parked!' if !parked?
    @garage.remove_car(self)
    @garage = nil
  end

  def parked?
    !@garage.nil?
  end
end
