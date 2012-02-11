require File.join(File.dirname(__FILE__), "..","src","garage")
require File.join(File.dirname(__FILE__), "..","src","police")
require File.join(File.dirname(__FILE__), "..","src","fbi_agent")
require File.join(File.dirname(__FILE__), "..","src","owner")

describe Garage do

  it "should notify parking lot owner when the garage is full" do
    owner = mock(:owner, :update => "")
    Owner.should_receive(:new).and_return(owner)
    capacity = 3
    garage = Garage.new(capacity)

    owner.should_receive(:update).with(garage, :garage_full).once

    capacity.times {garage.add_car(Object.new)}
  end

  it "should notify parking lot owner when the garage has space again" do
    owner = mock(:owner, :update => "")
    Owner.should_receive(:new).and_return(owner)
    capacity = 3
    garage = Garage.new(capacity)

    owner.should_receive(:update).with(garage, :garage_has_space).once

    cars = capacity.times.collect do
      car = Object.new
      garage.add_car(car)
      car
    end

    garage.remove_car(cars.first)
  end

  it "should notify the fbi agent when the garage is 80% full" do
    agent = mock(:fbi_agent, :update => "")
    FBIAgent.should_receive(:new).and_return(agent)
    capacity = 10
    garage = Garage.new(capacity)

    extent = (80.0/100.0)
    agent.should_receive(:update).with(garage, :garage_eighty_percent_full).once
    (capacity * extent).round.times {garage.add_car(Object.new)}
  end

  it "should notify the fbi agent when the garage is no longer 80% full" do
    agent = mock(:fbi_agent, :update => "")
    FBIAgent.should_receive(:new).and_return(agent)
    capacity = 10
    garage = Garage.new(capacity)

    extent = (80.0/100.0)
    agent.should_receive(:update).with(garage, :garage_no_longer_eighty_percent_full).once
    cars = (capacity * extent).round.times.collect do
      car = Object.new
      garage.add_car(car)
      car
    end
    garage.remove_car(cars.first)
  end

  it "should notify police when a car is not found" do
    police = mock(:police, :update => "")
    Police.should_receive(:new).and_return(police)
    garage = Garage.new(3)
    car = Object.new
    garage.add_car(car)
    garage.should_receive(:has_car?).with(car).and_return(false)

    police.should_receive(:update).with(car, :car_not_found)

    garage.remove_car(car)
  end

  it "should notify fbi agent when a car is not found" do
    agent = mock(:fbi_agent, :update => "")
    FBIAgent.should_receive(:new).and_return(agent)
    garage = Garage.new(3)
    car = Object.new
    garage.add_car(car)
    garage.should_receive(:has_car?).with(car).and_return(false)

    agent.should_receive(:update).with(car, :car_not_found)

    garage.remove_car(car)
  end

end
