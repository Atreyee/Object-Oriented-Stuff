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
    has_car?(car) ? @cars.delete(car) : Police.new.send_apb(car)
  end

  def has_car?(car)
    @cars.include?(car)
  end
end
