class Trains
  attr_accessor :cargo_trains, :passenger_trains

  def initialize(name_train)
    @name_train = name_train
    @tcargo_trains = []
    @passenger_trains = []
  end

  def add_cargo
    @cargo_trains << @name_train
  end

  def add_passenger
    @passenger_trains << @name_train
  end
end