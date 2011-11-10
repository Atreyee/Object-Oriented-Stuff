require File.join(File.dirname(__FILE__), "..","src","car")

describe Car do
  it "should be capable of being parked" do
    car = Car.new
    car.park("Panchsheel Tech Park")

    car.parked?.should be_true
    car.location.should == "Panchsheel Tech Park"

    car.retrieve
    car.park("City Pride Kothrud")

    car.parked?.should be_true
    car.location.should == "City Pride Kothrud"
  end

  it "should not be able to park a car which is already parked" do
    car = Car.new
    car.park("Some Place")

    lambda { car.park("new place") }.should raise_error('Car already parked!')
  end

  it "should be capable of being retreived from parking" do
    car = Car.new
    car.park("Panchsheel Tech Park")
    car.retrieve

    car.parked?.should be_false
    car.location.should be_empty
  end

  it "should not be able to retrieve a car which is not parked" do
    car = Car.new
    lambda { car.retrieve }.should raise_error('Car not parked!')
  end

end
