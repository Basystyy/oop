class Station

  attr_reader :trains
  
  def initialize(name)
    @name = name
    @trains = []
  end
  
  def take(train)
    trains << train
  end

  def send(train)
    trains.delete(train)
  end

  def view_all
    trains.each do |train|
      puts "#{train.number} - #{train.type}"
    end
  end

  def view_cargo
    trains.each do |train|
      puts train.number if train.type = :cargo
    end
  end

  def view_passenger
    trains.each do |train|
      puts train.number if train.type = :passenger
    end
  end 

end