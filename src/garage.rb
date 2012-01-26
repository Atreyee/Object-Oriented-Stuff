class Garage

  def add_car(car)
    @cars << car
  end

  def full?(extent = 100/100)
    (@capacity * extent) == @cars.count
  end

  def initialize(capacity)
    @capacity = capacity
    @cars = []
  end

  def remove_car(car)
    @cars.delete(car)
  end
end
