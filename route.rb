class Route
  attr_accessor :route_list
  attr_reader :name_route

  def initialize(name_route, name_start, name_end)
    @name_route = name_route
    @routes = []
    @route_list = []
    name_route << @routes
    name_start << @route_list if Station.@list_stations.include?(name_start)
    name_end << @route_list if Station.@list_stations.include?(name_end)
  end

  def add_station(name_station, number)
    if Station.@list_stations.include?(name_station)
      if number < @list_stations.length
        if number <= 2
        @list_stations.insert[name_station, (number.t0_i - 2)]
        end
      end
    end
  end

  def del_staiton(name_station)
    if @route_list.include?(name_station)
      if name_station != @route_list.first || name_station != @route_list.last
        @route_list.delete(name_station)
      end
    end
  end

  def view_statitons
    puts @route_list
  end
  
end