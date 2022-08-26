class PassengerTrain < Train

  def add(wagon)
    return if moving?
    return unless wagon.is_a?(PassengerWagon)
    @wagons << wagon
  end

end