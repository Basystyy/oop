class Station
  include InstanceCounter

  attr_reader :trains, :name

  @@stations = []

  class << self
    def all
      @@stations.each do |station|
        station
      end
    end
  end
  
  def initialize(name)
    @@stations << self
    @name = name
    @trains = []
  end
  
  def take(train)
    trains << train
  end

  def send(train)
    trains.delete(train)
  end

  def view_all
    trains.each do |train|
      puts "#{train.number} - #{train.class}"
    end
  end

  def view_cargo
    trains.each do |train|
      puts train.number if train.class == CargoTrain
    end
  end

  def view_passenger
    trains.each do |train|
      puts train.number if train.class == PassengerTrain
    end
  end

end