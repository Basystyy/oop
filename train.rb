class Train
  attr_reader :station, :route, :number, :speed, :wagons, :name
  
  def initialize(number)
    @speed = 0
    @number = number
    @wagons = []
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
    return if verify_speed
    wagons.delete(wagon) if wagons.include?(wagon)
  end

  protected
  
  def verify_speed
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