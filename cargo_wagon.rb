# frozen_string_literal: true

class CargoWagon < Wagon
  attr_reader :loaded_volume, :capacity

  def initialize(capacity)
    super
    @capacity = capacity
    @loaded_volume = 0
  end

  # def strong_attr_accessor(self.free_volume, self.free_volume.class)

  # end

  def load(volume)
    raise 'Недостаточно свободного места' if (volume + loaded_volume) > @capacity

    @loaded_volume += volume
    puts "Груз загружен. Свободного места #{free_volume}"
  rescue StandardError => e
    puts "#{e}. Груз не загружен! Свободно #{free_volume}"
  end

  def unload(volume)
    raise 'Попытка выгрузить несуществующий груз!!!' if @loaded_volume < volume

    @loaded_volume -= volume
    puts 'Груз выгружен.'
  rescue StandardError => e
    puts "#{e} Груз не выгружен."
  end

  def free_volume
    capacity - loaded_volume
  end
end
