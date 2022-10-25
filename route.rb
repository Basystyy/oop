class Route
  include InstanceCounter
  extend Store

  attr_reader :stations, :name

  NAME_FORMAT = /^[a-z].+[a-z]+$/i

  def initialize(name, start, last)
    @name = name
    validate!
    @stations = [start, last]
    self.class.add_object(self)
    register_instance
  end

  def validate!
    raise "Отсутствие названия маршрута недопустимо!" if name == ''
    raise "Несоответсвие формата названия маршрута" if name !~ NAME_FORMAT
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