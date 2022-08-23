require_relative './train'
require_relative './station'
require_relative './route'
require_relative './cargo_train'
require_relative './passenger_train'
require_relative './cargo_wagon'
require_relative './passenger_wagon'

class Menu
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end    

  #menu_0 стартовое меню
  def menu
    puts "Введите 1, чтобы добавить станцию"
    puts "Введите 2, чтобы добавить поезд"
    puts "Введите 3, чтобы создать маршрут"
    puts "Введите 4, чтобы изменить СУЩЕСТВУЮЩИЙ маршрут"
    puts "Введите 5, чтобы назначить маршрут СУЩЕСТВУЮЩЕМУ поезду"
    puts "Введите 6, чтобы добавить вагон к СУЩЕСТВУЮЩЕМУ поезду"
    puts "Введите 7, чтобы отцепить СУЩЕСТВУЮЩИЙ ПРИЦЕПЛЕННЫЙ вагон от поезда"
    puts "Введите 8, чтобы пенреместить СУЩЕСТВУЮЩИЙ поезд по НАЗНАЧЕНННОМУ маршруту"
    puts "Введите 9, чтобы просмотреть список станций или список поездов на станции"
    menu_0 = gets.chomp.to_i
    add_station if menu_0 == 1
    add_train if menu_0 == 2
    add_route if menu_0 == 3
    change_route if menu_0 == 4
    assign_route if menu_0 == 5
    add_wagon if menu_0 == 6
    del_wagon if menu_0 == 7
    run_train if menu_0 == 8
    view if menu_0 == 9
  end

  #menu_1 добавить станцию
  def add_station
    puts "Введите название станции"
    @stations << Station.new(gets.chomp)
    menu
  end

  #menu_2 добавить поезд
  def add_train
    puts "Введите 1 для создания пассажирского, или 2 для создания грузового поезда"
    flag = gets.chomp.to_i
    puts "Введите номер поезда"
    number = gets.chomp.to_s
    @trains << Passenger_train.new(number) if flag == 1
    @trains << Cargo_train.new(number) if flag == 2
    menu
  end

  #menu_3 создать маршрут
  def add_route
    puts "Введите название маршрута"
    name = gets.chomp.to_s
    show_stations
    puts "Введите порядковый номер начальной станции"
    start = @stations[gets.chomp.to_i - 1]
    puts "Введите порядковый номер конечной станции"
    last = @stations[gets.chomp.to_i - 1]
    @routes << Route.new(name, start, last)
    menu
  end

  #menu_4 изменить маршрут
  def change_route
    route = select_route
    route.view
    puts "Введите порядковый номер новой станции (кроме первой и последней)"
    flag_route = gets.chomp.to_i
    show_stations
    puts "Введите порядковый номер добавляемой станции"
    route.add(@stations[gets.chomp.to_i - 1], flag_route)
    menu
  end

  #menu_5 назначить маршрут
  def assign_route
    train = select_train
    route = select_route
    train.change(route)
    menu
  end

  #menu_6 добавить вагон
  def add_wagon
    train = select_train
    speed = train.speed
    train.break
    wagon = Cargo.new if train.type == :cargo
    wagon = Passenger.new if train.type == :passenger
    train.add(wagon)
    train.speed_up(speed)
    menu
  end

  #menu_7 удалить вагон
  def del_wagon
    train = select_train
    speed = train.speed
    train.break
    train.wagons.each.with_index(1) do |name, index|
      puts "#{index} - - #{name.type}"
    end
    puts "Введите порядковый номер удаляемого вагона"
    wagon = train.wagons[gets.chomp.to_i - 1]
    train.wagons.delete(wagon)
    train.speed_up(speed)
    menu
  end

  #menu_8 перемещение поезда по маршруту
  def run_train
    train = select_train
    puts "Введите 1 для перемещения вперед, или 2 - для перемещения назад по маршруту"
    vector = gets.chomp.to_i
    train.forward if vector == 1
    train.ahead if vector == 2
    menu
  end

  #menu_9 просмотр станций и поездов на них
  def view
    show_stations
    puts "Введите порядковый номер станции"
    @stations[gets.chomp.to_i - 1].view_all
    menu
  end

  private
  def show_stations
    puts "Перечень ВСЕХ станций:"
    @stations.each.with_index(1) do |name, index|
      puts "#{index} - - #{name.name}"
    end
  end

  def select_route
    @routes.each.with_index(1) do |name, index|
      puts "#{index} - - #{name.name}"
    end
    puts "Введите порядковый номер маршрута"
    @routes[gets.chomp.to_i - 1]
  end

  def select_train
    @trains.each.with_index(1) do |name, index|
      puts "#{index} - - #{name.number}"
    end
    puts "Введите порядковый номер поезда"
    @trains[gets.chomp.to_i - 1]
  end

  start = Menu.new
  start.menu

end