require File.join(File.dirname(__FILE__), "..","src","garage")
require File.join(File.dirname(__FILE__), "..","src","police")

describe Garage do

  it "should return correctly whether the garage is full" do
    capacity = 3
    garage = Garage.new(capacity)

    garage.full?.should be_false

    (capacity - 1).times {garage.add_car(Object.new)}

    garage.full?.should be_false

    garage.add_car(Object.new)
    garage.full?.should be_true
  end

  it "should tell that the garage is not full when cars have been retrieved from the full garage" do
    capacity = 3
    garage = Garage.new(capacity)

    cars = capacity.times.collect do
      car = Object.new
      garage.add_car(car)
      car
    end

    garage.full?.should be_true

    garage.remove_car(cars.first)
    garage.full?.should be_false
  end

  it "should return correctly whether the garage is 80% full" do
    capacity = 10
    garage = Garage.new(capacity)

    extent = (80.0/100.0)
    garage.full?(extent).should be_false

    (capacity * extent).round.times {garage.add_car(Object.new)}

    garage.full?(extent).should be_true
  end

  it "should return correctly whether the garage is not 80% full" do
    capacity = 10
    garage = Garage.new(capacity)

    extent = (80.0/100.0)
    garage.full?(extent).should be_false

    (capacity * (70/100.0)).round.times {garage.add_car(Object.new)}

    garage.full?(extent).should be_false
  end

  it "should return correctly whether the car is found at a garage" do
    garage = Garage.new(3)
    car = Object.new
    garage.add_car(car)
    garage.has_car?(car).should be_true
    garage.has_car?(Object.new).should be_false
  end

  it "should notify police when a car is not found" do
    garage = Garage.new(3)
    car = Object.new
    garage.add_car(car)

    garage.should_receive(:has_car?).with(car).and_return(false)
    police = mock(:police)
    Police.should_receive(:new).and_return(police)
    police.should_receive(:send_apb).with(car)

    garage.remove_car(car)
  end
end
