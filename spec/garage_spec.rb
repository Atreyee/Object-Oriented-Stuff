require File.join(File.dirname(__FILE__), "..","src","garage")
require File.join(File.dirname(__FILE__), "..","src","car")

describe Garage do
  it "should return correctly whether the garage is full" do
    capacity = 3
    garage = Garage.new(capacity)

    garage.full?.should be_false

    2.times {garage.cars << Car.new}
    garage.full?.should be_false

    garage.cars << Car.new
    garage.full?.should be_true
  end
end
