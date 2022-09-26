class Route
  include InstanceCounter

  attr_reader :stations, :name

  def initialize(name, start, last)
    register_instance
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
    puts "Перечень станций в маршруте:"
    @stations.each.with_index(1) do |name, index|
      puts "#{index} - - #{name.name}"
    end
  end

end