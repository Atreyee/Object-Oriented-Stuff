require File.join(File.dirname(__FILE__), "..","src","garage")

describe Garage do
  it {should have_many(:cars)}
end
