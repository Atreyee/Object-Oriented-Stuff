require 'observer'
class Garage
  include Observable

  def initialize(capacity)
    @capacity = capacity
    @cars = []
    add_observer Police.new
    add_observer FBIAgent.new
    add_observer Owner.new
  end

  def add_car(car)
    @cars << car
    notify(:garage_full) if full?
  end

  def remove_car(car)
    if has_car?(car)
      if full?
        @cars.delete(car)
        notify(:garage_has_space)
      else
        @cars.delete(car)
      end
    else
      notify(:car_not_found, car)
    end
  end

  def full?(extent = 100/100)
    (@capacity * extent) == @cars.count
  end

  private
  def notify(message, changed_object = self)
    changed
    notify_observers(changed_object, message)
  end

  def has_car?(car)
    @cars.include?(car)
  end

end
