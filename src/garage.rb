class Garage

  def cars
    @cars ||= []
  end

  def cars=(car)
    cars << car
  end

  def full?
    @capacity == cars.count
  end

  def initialize(capacity)
    @capacity = capacity
  end
end
