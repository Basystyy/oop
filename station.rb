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
    view do |train, index_1|
      next unless train.is_a?(CargoTrain)

      puts "#{index_1} - #{train.name} - cargo - #{train.wagons.length}"
      train.view do |wagon, index_2|
        puts "  #{index_2} - cargo - свободно места: #{(wagon.capacity - wagon.loaded_volume)} - занято: #{wagon.loaded_volume}"
      end
    end
  end

  def view_passenger
    view do |train, index_1|
      next unless train.is_a?(PassengerTrain)

      puts "#{index_1} - #{train.name} - passenger - #{train.wagons.length}"
      train.view do |wagon, index_2|
        puts "  #{index_2} - passenger - свободно мест: #{(wagon.seats - wagon.occupied_seats)} - занято: #{wagon.occupied_seats}"
      end
    end
  end
  
  def view(&block)
    trains.each.with_index(1) do |train, index|
      yield(train, index) if block_given?
    end
  end

end