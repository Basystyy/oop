# frozen_string_literal: true

class PassengerWagon < Wagon
  attr_reader :occupied_seats, :seats

  def initialize(seats)
    super
    @seats = seats
    @occupied_seats = 0
  end

  def occupied_seats_history
    history
  end

  def put
    raise 'Нет свободных мест.' if @occupied_seats == @seats

    @occupied_seats += 1
    puts "Пассажир занял свое место. Свободно мест #{free_seats}"
  rescue StandardError => e
    puts "#{e}. Пассажир не загружен в вагон!"
  end

  def plant
    raise 'Попытка высадить несуществующего пассажира!!!' if @occupied_seats.zero?

    @occupied_seats -= 1
    puts 'Пассажир высажен.'
  rescue StandardError => e
    puts "#{e} Никто не покинул вагон."
  end

  def free_seats
    seats - occupied_seats
  end
end
