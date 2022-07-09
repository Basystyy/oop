class Station
  attr_accessor :list

  def initialize(name_station)
    @name_station = name_station
    @list = []
  end

  def take_train(name_train)
    if Trains.cargo_trains.include?(name_train)
      @list << name_train
      if Trains.passenger_trains.include?(name_train)
        @list << name_train
      end
    end
  end

  def send_train(name_train)
    @list.delete(name_train) if @list.include?(name_train)
  end

  def view_all
    @list
  end

  def view_cargo
    @list & Trains.cargo_trains
  end

  def view_passenger
    @list & Trains.passenger_trains
  end
end