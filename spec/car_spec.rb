require File.join(File.dirname(__FILE__), "..","src","car")

describe Car do

  before :each do
    @garage = Garage.new(2)
  end

  it "should be capable of being parked" do
    car = Car.new
    car.park(@garage)

    car.parked?.should be_true
    car.garage.should == @garage

    car.retrieve

    car.park(@garage)
    car.parked?.should be_true
  end

  it "should not be able to park a car which is already parked" do
    car = Car.new
    car.park(@garage)

    lambda { car.park(@garage) }.should raise_error('Car already parked!')
  end

  it "should be capable of being retreived from parking" do
    car = Car.new
    car.park(@garage)
    car.retrieve

    car.parked?.should be_false
    car.garage.should be_nil
  end

  it "should not be able to retrieve a car which is not parked" do
    car = Car.new
    lambda { car.retrieve }.should raise_error('Car not parked!')
  end

end
