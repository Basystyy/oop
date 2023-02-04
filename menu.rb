# frozen_string_literal: true

class Menu
  include Display
  attr_reader :trains

  def menu
    select = nil
    while select != 0
      puts 'Введите 1, чтобы добавить станцию'
      puts 'Введите 2, чтобы добавить поезд'
      puts 'Введите 3, чтобы создать маршрут'
      puts 'Введите 4, чтобы изменить маршрут'
      puts 'Введите 5, чтобы назначить маршрут поезду'
      puts 'Введите 6, чтобы добавить вагон к поезду'
      puts 'Введите 7, чтобы отцепить вагон от поезда'
      puts 'Введите 8, чтобы пенреместить поезд по маршруту'
      puts 'Введите 9, чтобы просмотреть список поездов на станции и список их вагонов'
      puts 'Введите 10, чтобы загрузить вагон или посадить пассажира'
      puts 'Введите 11, чтобы разгрузить вагон или высадить пассажира'
      puts 'Введите 0, чтобы выйти из приложения'
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
        view_train
      when 10
        load_wagon
      when 11
        unload_wagon
      end
    end
  end

  def add_station
    puts 'Введите название станции'
    Station.new(gets.chomp)
    puts 'Станция создана.'
  rescue StandardError => e
    puts "#{e} Станция не создана!"
  end

  def add_train
    puts 'Введите 1 для создания пассажирского, или 2 для создания грузового поезда'
    flag = gets.chomp.to_i
    puts 'Введите номер поезда'
    name = gets.chomp
    PassengerTrain.new(name) if flag == 1
    CargoTrain.new(name) if flag == 2
    puts 'Поезд создан.'
  rescue StandardError => e
    puts "#{e} Поезд не создан!"
  end

  def add_route
    puts 'Введите название маршрута'
    name = gets.chomp
    show_stations
    puts 'Введите порядковый номер начальной станции'
    start = Station.all[gets.chomp.to_i - 1]
    puts 'Введите порядковый номер конечной станции'
    last = Station.all[gets.chomp.to_i - 1]
    Route.new(name, start, last)
    puts 'Маршрут создан.'
  rescue StandardError => e
    puts "#{e} Маршрут не создан!"
  end

  def change_route
    route = select_route
    route.view
    puts 'Введите порядковый номер новой станции (кроме первой и последней)'
    flag_route = gets.chomp.to_i
    show_stations
    puts 'Введите порядковый номер добавляемой станции'
    route.add(Station.all[gets.chomp.to_i - 1], flag_route - 1)
  end

  def assign_route
    train = select_train
    route = select_route
    train.change(route)
  end

  def add_wagon
    puts 'Введите объем для грузового или кол-во мест для пассажирского'
    capacity = gets.chomp.to_i
    train = select_train
    speed = train.speed
    train.break
    wagon = CargoWagon.new(capacity) if train.is_a?(CargoTrain)
    wagon = PassengerWagon.new(capacity) if train.is_a?(PassengerTrain)
    train.add(wagon)
    train.speed_up(speed)
  end

  def del_wagon
    train = select_train
    speed = train.speed
    train.break
    train.view_train
    puts 'Введите порядковый номер удаляемого вагона'
    wagon = train.wagons[gets.chomp.to_i - 1]
    train.wagons.delete(wagon)
    train.speed_up(speed)
  end

  def run_train
    train = select_train
    puts 'Введите 1 для перемещения вперед, или 2 - для перемещения назад по маршруту'
    vector = gets.chomp.to_i
    train.forward if vector == 1
    train.backward if vector == 2
  end

  def view_train
    show_stations
    puts 'Введите порядковый номер станции'
    station = Station.all[gets.chomp.to_i - 1]
    station.view_all
  end

  def load_wagon
    wagon = select_wagon
    if wagon.is_a?(CargoWagon)
      puts 'Введите загружаемый объем'
      capacity = gets.chomp.to_f
      wagon.load(capacity)
    end
    wagon.put if wagon.is_a?(PassengerWagon)
  end

  def unload_wagon
    wagon = select_wagon
    if wagon.is_a?(CargoWagon)
      puts 'Введите выгружаемый объем'
      capacity = gets.chomp.to_f
      wagon.unload(capacity)
    end
    wagon.plant if wagon.is_a?(PassengerWagon)
  end

  private

  def show_stations
    puts 'Перечень ВСЕХ станций:'
    Station.all.each.with_index(1) do |station, index|
      puts "#{index} - - #{station.name}"
    end
  end

  def select_route
    Route.all.each.with_index(1) do |route, index|
      puts "#{index} - - #{route.name}"
    end
    puts 'Введите порядковый номер маршрута'
    Route.all[gets.chomp.to_i - 1]
  end

  def select_train
    trains = PassengerTrain.all + CargoTrain.all
    PassengerTrain.all.each.with_index(1) do |train, index1|
      puts "#{index1} - #{train.name} - passenger - #{train.wagons.length}"
      train.wagons.each.with_index(1) do |wagon, index2|
        display_passenger(wagon, index2)
      end
    end
    CargoTrain.all.each.with_index(PassengerTrain.all.length + 1) do |train, index1|
      puts "#{index1} - #{train.name} - cargo - #{train.wagons.length}"
      train.wagons.each.with_index(1) do |wagon, index2|
        display_cargo(wagon, index2)
      end
    end
    puts 'Введите порядковый номер поезда'
    trains[gets.chomp.to_i - 1]
  end

  def select_wagon
    train = select_train
    train.wagons.each.with_index(1) do |wagon, index|
      if wagon.is_a?(CargoWagon)
        display_cargo(wagon, index2)
      end
      if wagon.is_a?(PassengerWagon)
        display_passenger(wagon, index2)
      end
    end
    puts 'Введите порядковый номер вагона'
    train.wagons[gets.chomp.to_i - 1]
  end
end
