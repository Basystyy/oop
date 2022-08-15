require_relative './train'
require_relative './station'
require_relative './route'
require_relative './cargo_train'
require_relative './passenger_train'
require_relative './cargo_wagon'
require_relative './passenger_wagon'

class Menu
  def initialize
    @menu_1_1 = 0
    @menu_2_3 = 0
    @menu_3_4 = 0
    @menu_6_2 = 0
    @stations_list = []
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
    menu_0 = gets.chomp
    add_station if menu_0 = 1
    add_train if menu_0 = 2
    add_route if menu_0 = 3
    change_route if menu_0 = 4
    ass_route if menu_0 = 5
    add_wagon if menu_0 = 6
    del_wagon if menu_0 = 7
    run_train if menu_0 = 8
    view if menu_0 = 9
  end

  #menu_1 добавить станцию
  def add_station
    puts "Внимание! Объект станции форимуется как 'st_' с добавлением следующего порядкового номера"
    @menu_1_1 += 1
    obj_station = "#{'st_'} + #{@menu_1_1.to_s}"
    puts "Введите название станции"
    menu_1_2 = gets.chomp
    obj_station = Station.new(menu_1_2)
    @stations_list << obj_station
    menu
  end

  #menu_2 добавить поезд
  def add_train
    puts "Внимание! Объект поезда форимуется как 'tr_' с добавлением следующего порядкового номера"
    puts "Введите 1 для создания пассажирского, или 2 для создания грузового поезда"
    menu_2_1 = gets.chomp
    puts "Введите номер поезда"
    menu_2_2 = gets.chomp
    @menu_2_3 += 1
    obj_train = "#{'tr_'} + #{@menu_2_3.to_s}"
    obj_train = Passenger_train.new(menu_2_2) if menu_2_1 == 1
    obj_train = Cargo_train.new(menu_2_2) if menu_2_1 == 2
    menu
  end

  #menu_3 создать маршрут
  def add_route
    puts "Внимание! Объект маршрута форимуется как 'rt_' с добавлением следующего порядкового номера"
    puts "Введите название маршрута"
    menu_3_1 = gets.chomp
    puts "Введите начальную станцию"
    menu_3_2 = gets.chomp
    puts "Введите конечную станцию"
    menu_3_3 = gets.chomp
    @menu_3_4 += 1
    obj_route = "#{'rt_'} + #{@menu_3_4.to_s}"
    obj_route = Route.new(menu_3_1, menu_3_2, menu_3_3)
    menu
  end

  #menu_4 изменить маршрут
  def change_route
    puts "Введите СУЩЕСТВУЮЩИЙ маршрут"
    menu_4_1 = gets.chomp
    puts "Нажмите 1 для добавления станции, или 2 для удаления станции"
    menu_4_2 = gets.chomp
    puts "Введите СУЩЕСТВУЮЩУЮ станцию"
    menu_4_3 = gets.chomp
    if menu_4_2 == 1
      puts "Введите порядковый номер станции в маршруте"
      menu_4_4 = gets.chomp.to_i
      menu_4_1.add(menu_4_3, menu_4_4)
    end
    if menu_4_3 == 2
      if menu_4_1.stations.include?(menu_4_3)
        menu_4_1.delete(menu_4_3)
      end
    end
    menu
  end

  #menu_5 назначить маршрут
  def ass_route
    puts "Введите СУЩЕСТВУЮЩИЙ поезд"
    menu_5_1 = gets.chomp
    puts "Введите СУЩЕСТВУЮЩИЙ маршрут"
    menu_5_2 = gets.chomp
    puts "ВНИМАНИЕ!!! поезд будет помещен на первую станцию маршрута!"
    menu_5_2.change(menu_5_1)
    menu
  end

  #menu_6 добавить вагон
  def add_wagon
    puts "Введите СУЩЕСТВУЮЩИЙ поезд"
    menu_6_1 = gets.chomp
    @menu_6_2 += 1
    obj_wagon = "#{'wg_'} + #{@menu_6_2.to_s}"
    obj_wagon = Cargo.new if menu_6_1.type == :cargo
    obj_wagon = Passenger.new if menu_6_1.type == :passenger
    speed = menu_6_1.speed
    menu_6_1.break
    menu_6_1.add(obj_wagon)
    menu_6_1.speed_up(speed)
    menu
  end

  #menu_7 удалить вагон
  def del_wagon
    puts "Введите СУЩЕСТВУЮЩИЙ поезд"
    menu_7_1 = gets.chomp
    puts "Введите СУЩЕСТВУЮЩИЙ ПРИЦЕПЛЕННЫЙ вагон"
    menu_7_2 = gets.chomp
    speed = menu_7_1.speed
    menu_7_1.break
    menu_7_1.delete(menu_7_2)
    menu_7_1.speed_up(speed)
    menu
  end

  #menu_8 перемещение поезда по маршруту
  def run_train
    puts "Введите СУЩЕСТВУЮЩИЙ поезд"
    menu_8_1 = gets.chomp
    puts "Введите 1 для движения вперед или 2 - для движения назад по маршруту"
    menu_8_2 = gets.chomp
    menu_8_1.forward if menu_8_2 == 1
    menu_8_1.ahead if menu_8_2 == 2
    menu
  end

  #menu_9 просмотр станций и поездов на них
  def view
    puts "Введите 1 для просмотра списка существующих станций или 2 для просмотра списка поездов на любой из них"
    menu_9_1 = gets.chomp
    if menu_9_1 == 1
      each @stations_list do |station|
        puts "#{station} - #{station.name}"
      end
    end
    if menu_9_1 == 2
      puts "Введите СУЩЕСТВУЮЩУЮ станцию"
      menu_9_2 = gets.chomp
      menu_9_2.view_all
    end
    menu
  end

end