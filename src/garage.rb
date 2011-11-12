class Garage

  def cars
    @cars ||= []
  end

  def cars=(car)
    cars << car
  end

  def full?
    @capacity == parked_cars.count
  end

  def initialize(capacity)
    @capacity = capacity
  end

  def remove_car(car)
    cars.delete(car)
  end

  private
  def parked_cars
    cars.select {|c| c.parked?}
  end

end
