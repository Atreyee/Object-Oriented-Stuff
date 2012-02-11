require 'observer'
class Garage
  include Observable

  def add_car(car)
    @cars << car
  end

  def full?(extent = 100/100)
    (@capacity * extent) == @cars.count
  end

  def initialize(capacity)
    @capacity = capacity
    @cars = []
    add_observer Police.new
    add_observer FBIAgent.new
  end

  def remove_car(car)
    if has_car?(car)
      @cars.delete(car)
    else
      changed
      notify_observers(car)
    end
  end

  def has_car?(car)
    @cars.include?(car)
  end
end
