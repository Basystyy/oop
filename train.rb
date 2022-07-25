class Train
  attr_reader :type, :cargo_train, :passenger_train, :speed, :number_wagons
  
  def initialize(name_train, type, number_wagons)
    @name_train = name_train
    @cargo_train = []
    @passenger_train = []
    @all_train = []
    @all_train << @name_train
    @cargo_train << @name_train if type == 'cargo'
    @passenger_train << @name_train if type == 'passenger'
    @type = type
    @speed = 0
    @number_wagons = number_wagons
  end

  def pick_up_speed(delta)
    @speed += delta
  end

  def break
    @speed = 0
  end

  def add_wagon
    @number_wagons += 1 if @speed.(0)?
  end

  def delete_wagon
    if @speed.(0)?
      if @number_wagons >= 1
        @number_wagons -= 1
      end
    end
  end

  def change_route(name_route)    
    if Route.routes.include?(name_route)
      @name_route = name_route
      @name_station = Route.@route_list.first
    end
  end

  def move_forvard
      if @name_station != Route.@route_list.last
        index = Route.@route_list.index(@name_station)
        @name_station = Route.@route_list[index + 1]
    end
  end

  def move_ahead
    if @name_station != Route.@route_list.first
      index = Route.@route_list.index(@name_station)
      @name_station = Route.@route_list[index - 1]
    end
  end

  def show_station
    index = Route.@route_list.index(@name_station)

    if index.(0)?
      previous_st = '-'
    else
      previous_st = Route.@route_list[index - 1]
    end

    if @name_station == Route.@route_list.last
      next_st = '-'
    else
      next_st = Route.@route_list[index + 1]
    end
    
    puts "#{previous_st}; #{@name_station}; #{next_st}"
end