class Station
  include InstanceCounter
  extend Store

  attr_reader :trains, :name

  NAME_FORMAT = /^[a-z]+$/i
  
  def initialize(name)
    @name = name
    validate!
    @trains = []
    self.class.add_object(self)
    register_instance
  end
  
  def validate!
    raise "Отсутствие названия станции недопустимо!" if name == ''
    raise "Несоответсвие формата названия станции!" if name !~ NAME_FORMAT
  end
  
  def take(train)
    trains << train
  end

  def send(train)
    trains.delete(train)
  end

  def view_all
    trains.each do |train|
      puts "#{train.name} - #{train.class}"
    end
  end

  def view_cargo
    trains.each do |train|
      puts train.name if train.class == CargoTrain
    end
  end

  def view_passenger
    trains.each do |train|
      puts train.name if train.class == PassengerTrain
    end
  end

end