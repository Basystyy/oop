class Train

include Manufacturer
include InstanceCounter
extend Store

  attr_reader :station, :route, :number, :speed, :wagons, :name

  NUMBER_CARGO = /^cargo\d+$/i
  NUMBER_PASS = /^pass\d+$/i
  
  def initialize(name)
    @name = name
    validate!
    @speed = 0
    @wagons = []
    @station = nil
    @route = nil
    self.class.add_object(self)
    register_instance
  end

  def validate!
    raise "Отсутствие номера поезда недопустимо!" if name == ''
    raise "Несоответсвие формата номера поезда!" if self.class.to_s == 'CargoTrain' && name !~ NUMBER_CARGO
    raise "Несоответсвие формата номера поезда!" if self.class.to_s == 'PassengerTrain' && name !~ NUMBER_PASS
    raise "Такой номер поезда уже существует, выберите другой." if self.class.find(name) != []
  end

  def speed_up(delta)
    @speed += delta
  end

  def break
    @speed = 0
  end

  def change(route)
    @route = route
    @station = route.first
    take
  end
  
  def forward
    if @station != route.last
      send
      @station = next_station
      take
    end
  end

  def backward
    if @station != route.first
      send
      @station = prev_station
      take
    end
  end

  def prev_station
    @route.stations[index - 1]
  end

  def current_station
    @station
  end

  def next_station
    @route.stations[index + 1] 
  end

  def delete(wagon)
    return if moving?
    wagons.delete(wagon) if wagons.include?(wagon)
  end

  def view_train
    self.wagons.each.with_index(1) do |wagon, index|
      puts "#{index} - - #{wagon.view_manufacturer}"
    end
  end

  protected
  
  def moving?
    !speed.zero?
  end

  private
  #используется только в этом классе
  def index
    @route.stations.index(@station)
  end

  def take
    @station.take(self)
  end

  def send
    @station.send(self)
  end

end