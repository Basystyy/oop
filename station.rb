class Station
  
  attr_accessor :list

  def initialize(name_station)
    @name_station = name_station
    @list = []
    @list_stations = []
    @list_stations << name_station if @list_stations.!include?(name_station)
  end

  def take_train(name_train)
    if Train.cargo_train.include?(name_train)
      @list << name_train
      if Train.passenger_train.include?(name_train)
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
    @list & Train.cargo_train
  end

  def view_passenger
    @list & Train.passenger_train
  end
end