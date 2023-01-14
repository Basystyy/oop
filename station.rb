class Station
  include InstanceCounter
  include Store

  attr_reader :trains, :name

  NAME_FORMAT = /^[a-z]+$/i
  
  def initialize(name)
    @name = name
    validate!
    @trains = []
    added_object
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
    view_cargo
    view_passenger
  end

  def view_cargo
    trains.each do |train|
      puts train.name if train.is_a?(CargoTrain)
    end
  end

  def view_passenger
    trains.each do |train|
      puts train.name if train.is_a?(PassengerTrain)
    end
  end

  def view(&block)
    trains.each do |train|
      yield(train) if block_given?
    end
  end

end