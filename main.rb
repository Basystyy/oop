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
    puts "Нажмите 1, чтобы добавить станцию"
    puts "Нажмите 2, чтобы добавить поезд"
    puts "Нажмите 3, чтобы создать маршрут"
    puts "Нажмите 4, чтобы изменить СУЩЕСТВУЮЩИЙ маршрут"
    puts "Нажмите 5, чтобы назначить маршрут СУЩЕСТВУЮЩЕМУ поезду"
    puts "Нажмите 6, чтобы добавить вагон к СУЩЕСТВУЮЩЕМУ поезду"
    puts "Нажмите 7, чтобы отцепить СУЩЕСТВУЮЩИЙ ПРИЦЕПЛЕННЫЙ вагон от поезда"
    puts "Нажмите 8, чтобы пенреместить СУЩЕСТВУЮЩИЙ поезд по НАЗНАЧЕНННОМУ маршруту"
    puts "нажмите 9, чтобы просмотреть список станций или список поездов на станции"
    menu_0 = gets.chomp.to_i
    add_station if menu_0 == 1
    add_train if menu_0 == 2
    add_route if menu_0 == 3
    change_route if menu_0 == 4
    ass_route if menu_0 == 5
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
    number = gets.chomp
    @trains << Passenger_train.new(number) if flag == 1
    @trains << Cargo_train.new(number) if flag == 2
    menu
  end

  #menu_3 создать маршрут
  def add_route
    puts "Введите название маршрута"
    name = gets.chomp
    st_select
    puts "Введите порядковый номер начальной станции"
    start = @stations[gets.chomp.to_i - 1]
    puts "Введите порядковый номер конечной станции"
    last = @stations[gets.chomp.to_i - 1]
    @routes << Route.new(name, start, last)
    menu
  end

  #menu_4 изменить маршрут
  def change_route
    rt_select
    route.view
    st_select
    puts "Введите порядковый номер добавляемой станции (кроме первой и последней)"
    flag = gets.chomp.to_i - 1
    station = @stations[flag]
    route.add(station, flag)
    menu
  end

  #menu_5 назначить маршрут
  def ass_route
    tr_select
    rt_select
    train.change(route)
    menu
  end

  #menu_6 добавить вагон
  def add_wagon
    tr_select
    type = train.type
    speed = train.speed
    train.break
    train.add(Cargo.new) if type == :cargo
    train.add(Passenger.new) if type == :passenger
    train.speed_up(speed)
    menu
  end

  #menu_7 удалить вагон
  def del_wagon
    tr_select
    type = train.type
    speed = train.speed
    train.break
    train.wagons.each.with_index(1) do |index, name|
      puts "#{index} - - #{name}"
    end
    puts "Введите порядковый номер удаляемого вагона"
    wagon = train.wagons[gets.chomp.to_i - 1]
    train.speed_up(speed)
    menu
  end

  #menu_8 перемещение поезда по маршруту
  def run_train
    tr_select
    puts "Введите 1 для перемещения вперед, ил 2 - для перемещения назад по маршруту"
    train.forward if gets.chomp.to_i == 1
    train.ahead if gets.chomp.to_i == 2
    menu
  end

  #menu_9 просмотр станций и поездов на них
  def view
    st_select
    puts "Введите порядковый номер станции"
    station = @stations[gets.chomp.to_i - 1]
    station.view_all
    menu
  end

  private
  def st_select
    @stations.each.with_index(1) do |name, index|
      puts "#{index} - - #{name.name}"
    end
  end

  def rt_select
    @routes.each.with_index(1) do |name, index|
      puts "#{index} - - #{name.name}"
    end
    puts "Введите порядковый номер маршрута"
    route = @routes[gets.chomp.to_i - 1]
    puts route.name
  end

  def tr_select
    @trains.each.with_index(1) do |name, index|
      puts "#{index} - - #{name.name}"
    end
    puts "Введите порядковый номер поезда"
    train = @trains[gets.chomp.to_i - 1]
    puts train.name
  end

  start = Menu.new
  start.menu

end