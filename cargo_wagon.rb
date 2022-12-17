class CargoWagon < Wagon

  def initialize(capacity)
    @capacity = capacity
    @free_volume = capacity
    @loaded_volume = 0
  end

  def download(volume)
    raise "Недостаточно свободного места" if volume > @free_volume
    @free_volume = @free_volume - volume
    puts "Груз загружен."
  rescue StandardError => error
    puts "#{error}. Груз не загружен! Свободно #{free_volume}"
  end

  def free_volume
    @free_volume
  end

  def loaded_volume
    @loaded_volume
  end

end