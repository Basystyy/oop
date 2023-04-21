# frozen_string_literal: true

class Train
  include Manufacturer
  include InstanceCounter
  include Store

  attr_reader :station, :route, :wagons, :name, :speed

  NAME_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze

  def initialize(name)
    @name = name
    validate!
    @speed = 0
    @wagons = []
    @station = nil
    @route = nil
    added_object
    register_instance
  end

  def validate!
    raise 'Отсутствие номера поезда недопустимо!' if name == ''
    raise 'Несоответсвие формата номера поезда!' if name !~ NAME_FORMAT
    raise 'Такой номер поезда уже существует, выберите другой.' if self.class.find(name) != []
  end

  def speed_up(delta)
    @speed += delta
  end

  def break
    @speed = 0
  end

  def change(route)
    @route = route
    @station = route.first
    take
  end

  def forward
    return unless @station != route.last

    send
    @station = next_station
    take
  end

  def backward
    return unless @station != route.first

    send
    @station = prev_station
    take
  end

  def prev_station
    @route.stations[index - 1]
  end

  def current_station
    @station
  end

  def next_station
    @route.stations[index + 1]
  end

  def delete(wagon)
    return if moving?

    wagons.delete(wagon) if wagons.include?(wagon)
  end

  def view_train
    wagons.each.with_index(1) do |wagon, index|
      puts "#{index} - - #{wagon.view_manufacturer}"
    end
  end

  def view
    wagons.each.with_index(1) do |wagon, index|
      yield(wagon, index) if block_given?
    end
  end

  protected

  def moving?
    !speed.zero?
  end

  private

  # используется только в этом классе
  def index
    @route.stations.index(@station)
  end

  def take
    @station.take(self)
  end

  def send
    @station.send(self)
  end
end
