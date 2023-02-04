# frozen_string_literal: true

class CargoTrain < Train
  def add(wagon)
    return if moving?
    return unless wagon.is_a?(CargoWagon)

    @wagons << wagon
  end
end
