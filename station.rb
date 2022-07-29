class Station

  attr_accessor :trains
  
  def initialize(name)
    @name = name
    @trains = []
    @train = nil
  end

  def take(train)
    @train = train
    trains << train
  end

  def send(train)
    @train = train
    trains.delete(train)
  end

  def view
    trains.each do |train|
      puts train.name
    end
  end

end