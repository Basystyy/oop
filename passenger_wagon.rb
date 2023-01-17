class PassengerWagon < Wagon

  attr_reader :occupied_seats, :seats

  def initialize(seats)
    @seats = seats
    @occupied_seats = 0
  end

  def put
    raise "Нет свободных мест." if @occupied_seats == @seats
    @occupied_seats += 1
    puts "Пассажир занял свое место."
  rescue StandardError => error
    puts "#{error}. Пассажир не загружен в вагон!"
  end

  def plant
    raise "Попытка высадить несуществующего пассажира!!!" if @occupied_seats == 0
    @occupied_seats -= 1
    puts "Пассажир высажен."
  rescue StandardError => error
    puts "#{error} Никто не покинул вагон."
  end

end