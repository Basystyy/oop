class Route
  attr_reader :stations, :name

  def initialize(name, start, last)
    @name = name
    @stations = [start, last]
  end
  
  def first
    @stations.first
  end

  def last
    @stations.last
  end

  def add(station, number)
    if @stations.index(last) >= (number - 1) && number >= 1
      index = number - 1
      @stations.insert(index, station)
    end
  end

  def delete(station)
    if station != last || station != first
      @stations.delete(station)
    end
  end

  def view
    @stations.each.with_index do |name, index|
      puts "#{index} - - #{name}"
    end
  end

end