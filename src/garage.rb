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
    notify(:garage_eighty_percent_full) if full?(80.0/100.0)
  end

  def remove_car(car)
    if has_car?(car)
      message = if full?
                  :garage_has_space
                elsif full?(80.0/100.0)
                  :garage_no_longer_eighty_percent_full
                end
      @cars.delete(car)
      notify(message) if message
    else
      notify(:car_not_found, car)
    end
  end

  private
  def full?(extent = 100/100)
    (@capacity * extent) == @cars.count
  end

  def notify(message, changed_object = self)
    changed
    notify_observers(changed_object, message)
  end

  def has_car?(car)
    @cars.include?(car)
  end

end
