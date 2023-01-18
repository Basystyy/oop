class CargoWagon < Wagon

  attr_reader :loaded_volume, :capacity

  def initialize(capacity)
    @capacity = capacity
    @loaded_volume = 0
  end

  def load(volume)
    raise "Недостаточно свободного места" if (volume + loaded_volume) > @capacity
    @loaded_volume += volume
    puts "Груз загружен. Свободного места #{free_volume}"
  rescue StandardError => error
    puts "#{error}. Груз не загружен! Свободно #{free_volume}"
  end

  def unload(volume)
    raise "Попытка выгрузить несуществующий груз!!!" if @loaded_volume < volume
    @loaded_volume -= volume
    puts "Груз выгружен."
  rescue StandardError => error
    puts "#{error} Груз не выгружен."
  end

  def free_volume
    capacity - loaded_volume
  end

end