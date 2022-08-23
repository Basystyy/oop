class Train
  attr_reader :station, :route, :number, :speed, :wagons, :name, :type
  
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
      @station = @route.stations[index + 1]
      take
    end
  end

  def ahead
    if @station != route.first
      send
      @station = @route.stations[index - 1]
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

  def add(wagon)
    return if verify_speed
    @wagons << wagon
  end

  def delete(wagon)
    return if verify_speed
    wagons.delete(wagon) if wagons.include?(wagon)
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

  def verify_speed
    !speed.zero?
  end

end