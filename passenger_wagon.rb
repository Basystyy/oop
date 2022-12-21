class PassengerWagon < Wagon

  def initialize(seats)
    @seats = seats
    @free_seats = seats
    @occupied_seats = 0
  end

  def put
    raise "Нет свободных мест." if @free_seats == 0
    @free_seats -= 1
    puts "Пассажир занял свое место."
  rescue StandardError => error
    puts "#{error}. Пассажир не загружен в вагон!"
  end

  def plant
    raise "Попытка высадить несуществующего пассажира!!!" if @occupied_seats == 0
    @free_seats += 1
    puts "Пассажир высажен."
  rescue StandardError => error
    puts "#{error} Никто не покинул вагон."
  end

  def free_seats
    @free_seats
  end

  def occupied_seats
    @occupied_seats
  end

end