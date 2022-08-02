class Train
  attr_reader :station, :route
  attr_accessor :speed, :number
  
  def initialize(number, type, wagons_qty)
    @speed = 0
    @number = number
    @type = type
    @wagons_qty = wagons_qty
  end

  def break
    @speed = 0
  end

  def add
    @wagons_qty += 1 if speed.zero?
  end

  def delete
    if speed.zero?
      if @wagons_qty >= 1
        @wagons_qty -= 1
      end
    end
  end

  def change(route)
    @route = route
    @station = route.stations.first
    @station.take(self)
  end

  def forward
  index = @route.stations.index(@station)
    if @station != @route.stations.last
      index += 1
      @station.send(self)
      @station = @route.stations[index]
      @station.take(self)
    end
  end

  def ahead
    index = @route.stations.index(@station)
    if @station != @route.stations.first
      index -= 1
      @station.send(self)
      @station = @route.stations[index]
      @station.take(self)
    end
  end

  def prev_station
    index = route.stations.index(@station)
    puts "Please, enter 1 for view previous station or 2 for go to previous station"
    act = gets.chomp.to_i
    if @station != @route.stations.first
      index -= 1
      return @route.stations[index] if act == 1
      self.ahead if act == 2
    end
  end

  def current_station
    @station
  end

  def next_station
    index = @route.stations.index(@station)
    puts "Please, enter 1 for view next station or 2 for go to next station"
    act = gets.chomp.to_i
    if @station != @route.stations.last
      index += 1
      return @route.stations[index] if act == 1
      self.forward if act == 2
    end
  end
end