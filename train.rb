class Train
  attr_reader :station, :route, :number, :speed
  
  def initialize(number, type, wagons_qty)
    @speed = 0
    @number = number
    @type = type
    @wagons_qty = wagons_qty
  end

  def speed_up(delta)
    @speed += delta
  end

  def break
    @speed = 0
  end

  def add
    @wagons_qty += 1 if speed.zero?
  end

  def delete
    return unless speed.zero?
    return if @wagons_qty < 1
    @wagons_qty -= 1
  end

  def change(route)
    @route = route
    @station = route.stations.first
    @station.take(self)
  end

  def index
    @route.stations.index(@station)
  end
  
  def forward
    if @station != @route.stations.last
      @station.send(self)
      @station = @route.stations[index + 1]
      @station.take(self)
    end
  end

  def ahead
    if @station != @route.stations.first
      @station.send(self)
      @station = @route.stations[index - 1]
      @station.take(self)
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

end