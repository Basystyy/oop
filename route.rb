# frozen_string_literal: true

class Route
  include InstanceCounter
  include Store

  attr_reader :stations, :name

  NAME_FORMAT = /^[a-z].+[a-z]+$/i.freeze

  def initialize(name, start, last)
    @name = name
    @stations = [start, last]
    validate!
    added_object
    register_instance
  end

  def validate!
    raise 'Отсутствие названия маршрута недопустимо!' if name == '' && name.nil?
    raise 'Несоответсвие формата названия маршрута' if name !~ NAME_FORMAT

    @stations.each do |name|
      raise 'Объект не может быть частью маршрута' unless name.is_a?(Station)
    end
  end

  def first
    @stations.first
  end

  def last
    @stations.last
  end

  def add(station, number)
    validate!
    return unless @stations.index(last) >= (number - 1) && number >= 1

    index = number - 1
    @stations.insert(index, station)
  end

  def delete(station)
    return unless station != last || station != first

    @stations.delete(station)
  end

  def view
    puts 'Перечень станций в маршруте:'
    @stations.each.with_index(1) do |name, index|
      puts "#{index} - - #{name.name}"
    end
  end
end
