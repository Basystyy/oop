# frozen_string_literal: true

module Display

  def display_cargo(wagon, index2)
    text = ['  ', index2, 'cargo',
            "свободно места: #{wagon.capacity - wagon.loaded_volume}",
            "занято: #{wagon.loaded_volume}"].join(' - ')
    puts text
  end

  def display_passenger(wagon, index2)
    text = ['  ', index2, 'passenger',
            "свободно мест: #{wagon.seats - wagon.occupied_seats}",
            "занято: #{wagon.occupied_seats}"].join(' - ')
    puts text
  end
end