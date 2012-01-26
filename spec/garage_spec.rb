require File.join(File.dirname(__FILE__), "..","src","garage")
require File.join(File.dirname(__FILE__), "..","src","car")

describe Garage do

  it "should return correctly whether the garage is full" do
    capacity = 3
    garage = Garage.new(capacity)

    garage.full?.should be_false

    (capacity - 1).times {Car.new.park(garage)}

    garage.full?.should be_false

    Car.new.park(garage)
    garage.full?.should be_true
  end

  it "should tell that the garage is not full when cars have been retrieved from the full garage" do
    capacity = 3
    garage = Garage.new(capacity)

    cars = capacity.times.collect do
      car = Car.new
      car.park(garage)
      car
    end

    garage.full?.should be_true

    cars.first.retrieve
    garage.full?.should be_false
  end

  it "should return correctly whether the garage is 80% full" do
    capacity = 10
    garage = Garage.new(capacity)

    extent = (80.0/100.0)
    garage.full?(extent).should be_false

    (capacity * extent).round.times {Car.new.park(garage)}

    garage.full?(extent).should be_true
  end

  it "should return correctly whether the garage is not 80% full" do
    capacity = 10
    garage = Garage.new(capacity)

    extent = (80.0/100.0)
    garage.full?(extent).should be_false

    (capacity * (70/100.0)).round.times {Car.new.park(garage)}

    garage.full?(extent).should be_false
  end

end
