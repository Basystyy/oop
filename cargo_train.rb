class CargoTrain < Train
  
  def add(wagon)
    return if verify_speed
    return unless wagon.is_a?(CargoWagon)
    @wagons << wagon
  end

end