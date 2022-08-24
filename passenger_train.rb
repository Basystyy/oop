class PassengerTrain < Train

  def add(wagon)
    return if verify_speed
    return unless wagon.is_a?(PassengerWagon)
    @wagons << wagon
  end

end