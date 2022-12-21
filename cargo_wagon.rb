class CargoWagon < Wagon

  def initialize(capacity)
    @capacity = capacity
    @free_volume = capacity
    @loaded_volume = 0
  end

  def load(volume)
    raise "Недостаточно свободного места" if volume > @free_volume
    @free_volume -= volume
    @loaded_volume += volume
    puts "Груз загружен."
  rescue StandardError => error
    puts "#{error}. Груз не загружен! Свободно #{free_volume}"
  end

  def unload(volume)
    raise "Попытка выгрузить несуществующий груз!!!" if @loaded_volume < volume
    @free_volume += volume
    @loaded_volume -= volume
    puts "Груз выгружен."
  rescue StandardError => error
    puts "#{error} Груз не выгружен."
  end

  def free_volume
    @free_volume
  end

  def loaded_volume
    @loaded_volume
  end

end