require File.join(File.dirname(__FILE__), "..","src","garage")
require File.join(File.dirname(__FILE__), "..","src","car")

describe Garage do

  it "should count only parked cars in considering its capacity" do
    capacity = 3
    garage = Garage.new(capacity)

    cars = capacity.times.collect do
      car = Car.new
      garage.cars << car
      car
    end

    garage.full?.should be_false

    cars.each {|car| car.park(garage)}

    garage.full?.should be_true
  end

  it "should return correctly whether the garage is full" do
    capacity = 3
    garage = Garage.new(capacity)

    garage.full?.should be_false

    2.times do
      car = Car.new
      garage.cars << car
      car.park(garage)
    end
    garage.full?.should be_false

    car = Car.new
    car.park(garage)
    garage.cars << car
    garage.full?.should be_true
  end

  it "should tell that the garage is not full when cars have been retrieved from the full garage" do
    capacity = 3
    garage = Garage.new(capacity)

    cars = capacity.times.collect do
      car = Car.new
      garage.cars << car
      car.park(garage)
      car
    end

    garage.full?.should be_true

    cars.first.retrieve
    garage.full?.should be_false
  end
end
