class Route
  attr_reader :stations, :name

  def initialize(name, start, last)
    @name = name
    @stations = [start, last]
  end

  def add(station, number)
    if @stations.index(@stations.last) >= (number - 2) && number >= 1
      index = number - 1
      @stations.insert(index, station)
    end
  end

  def delete(station)
    if station != @stations.last || station != @stations.first
      @stations.delete(station)
    end
  end

end