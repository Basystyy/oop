class Train

include Manufacturer
include InstanceCounter

  attr_reader :station, :route, :number, :speed, :wagons, :name

  class << self

    @@trains = []
    def find(number)
      @@trains.select { |train| train.number == number }
    end

  end
  
  def initialize(number)
   raise if self.class.to_s == 'Train'
    register_instance
    @@trains << self
    @speed = 0
    @number = number
    @wagons = []
    @station = nil
    @route = nil
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
      puts "#{index} - - #{wagon.manufacturer}"
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