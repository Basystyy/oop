class Menu

  attr_reader :trains

  def menu
    select = nil
    while select != 0 do
    puts "Введите 1, чтобы добавить станцию"
    puts "Введите 2, чтобы добавить поезд"
    puts "Введите 3, чтобы создать маршрут"
    puts "Введите 4, чтобы изменить СУЩЕСТВУЮЩИЙ маршрут"
    puts "Введите 5, чтобы назначить маршрут СУЩЕСТВУЮЩЕМУ поезду"
    puts "Введите 6, чтобы добавить вагон к СУЩЕСТВУЮЩЕМУ поезду"
    puts "Введите 7, чтобы отцепить СУЩЕСТВУЮЩИЙ ПРИЦЕПЛЕННЫЙ вагон от поезда"
    puts "Введите 8, чтобы пенреместить СУЩЕСТВУЮЩИЙ поезд по НАЗНАЧЕНННОМУ маршруту"
    puts "Введите 9, чтобы просмотреть список станций или список поездов на станции"
    puts "Введите 0, чтобы выйти из приложения"
    select = gets.chomp.to_i
      case select
        when 1
          add_station
        when 2
          add_train
        when 3
          add_route
        when 4
          change_route
        when 5
          assign_route
        when 6
          add_wagon
        when 7
          del_wagon
        when 8
          run_train
        when 9
          view
      end
    end
  end
end

  def add_station
    puts "Введите название станции"
    Station.new(gets.chomp)
    puts "Станция создана."
  rescue => error
    puts "#{error} Станция не создана!"
  end

  def add_train
    puts "Введите 1 для создания пассажирского, или 2 для создания грузового поезда"
    flag = gets.chomp.to_i
    puts "Введите номер поезда"
    name = gets.chomp
    PassengerTrain.new(name) if flag == 1
    CargoTrain.new(name) if flag == 2
    puts "Поезд создан."
  rescue => error
    puts "#{error} Поезд не создан!"
  end

  def add_route
    puts "Введите название маршрута"
    name = gets.chomp
    show_stations
    puts "Введите порядковый номер начальной станции"
    start = Station.all[gets.chomp.to_i - 1]
    puts "Введите порядковый номер конечной станции"
    last = Station.all[gets.chomp.to_i - 1]
    Route.new(name, start, last)
    puts "Маршрут создан."
  rescue => error
    puts "#{error} Маршрут не создан!"
  end

  def change_route
    route = select_route
    route.view
    puts "Введите порядковый номер новой станции (кроме первой и последней)"
    flag_route = gets.chomp.to_i
    show_stations
    puts "Введите порядковый номер добавляемой станции"
    route.add(Station.all[gets.chomp.to_i - 1], flag_route - 1)
  end

  def assign_route
    train = select_train
    route = select_route
    train.change(route)
  end

  def add_wagon
    train = select_train
    speed = train.speed
    train.break
    wagon = CargoWagon.new if train.is_a?(CargoTrain)
    wagon = PassengerWagon.new if train.is_a?(PassengerTrain)
    train.add(wagon)
    train.speed_up(speed)
  end

  def del_wagon
    train = select_train
    speed = train.speed
    train.break
    train.view_train
    puts "Введите порядковый номер удаляемого вагона"
    wagon = train.wagons[gets.chomp.to_i - 1]
    train.wagons.delete(wagon)
    train.speed_up(speed)
  end

  def run_train
    train = select_train
    puts "Введите 1 для перемещения вперед, или 2 - для перемещения назад по маршруту"
    vector = gets.chomp.to_i
    train.forward if vector == 1
    train.backward if vector == 2
  end

  def view
    show_stations
    puts "Введите порядковый номер станции"
    Station.all[gets.chomp.to_i - 1].view_all
  end

  private
  def show_stations
    puts "Перечень ВСЕХ станций:"
    Station.all.each.with_index(1) do |station, index|
      puts "#{index} - - #{station.name}"
    end
  end

  def select_route
    Route.all.each.with_index(1) do |route, index|
      puts "#{index} - - #{route.name}"
    end
    puts "Введите порядковый номер маршрута"
    Route.all[gets.chomp.to_i - 1]
  end

  def select_train
    trains = PassengerTrain.all + CargoTrain.all
    trains.each.with_index(1) do |train, index|
      puts "#{index} - - #{train.name}"
    end
    puts "Введите порядковый номер поезда"
    trains[gets.chomp.to_i - 1]
  end