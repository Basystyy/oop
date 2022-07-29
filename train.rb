class Train
  attr_reader :station, :route
  attr_accessor :speed, :number
  
  def initialize(name, type, number)
    @speed = 0
    @number = number
    @route = nil
    @station = nil
  end

  def break
    @speed = 0
  end

  def add
    @number += 1 if speed.zero?
  end

  def delete
    if speed.zero?
      if @number >= 1
        @number -= 1
      end
    end
  end

  def change(route)
    @route = route
    @station = route.stations.first
  end

  def forvard
  index = @route.stations.index(@station)
  index += 1
  @station = @route.stations[index]
  end

  def ahead
    index = @route.stations.index(@station)
    index -= 1
    @station = @route.stations[index]
  end

  def view
    index = route.stations.index(@station)
    st_prev = route.stations[index - 1]
    st_next = route.station[index + 1]
    puts "#{st_prev} -- #{@station} -- #{st_next}"
  end
end