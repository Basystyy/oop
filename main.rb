# frozen_string_literal: true

require_relative './accessors'
require_relative './display'
require_relative './menu'
require_relative './manufacturer'
require_relative './instance_counter'
require_relative './store'
require_relative './train'
require_relative './station'
require_relative './route'
require_relative './cargo_train'
require_relative './passenger_train'
require_relative './wagon'
require_relative './cargo_wagon'
require_relative './passenger_wagon'

st1 = Station.new('Kyiv')
st2 = Station.new('Vinnitsa')
st3 = Station.new('Rovno')
st4 = Station.new('Lutsk')
pas01 = PassengerTrain.new('pas01')
pas02 = PassengerTrain.new('pas02')
pas03 = PassengerTrain.new('pas03')
car01 = CargoTrain.new('car01')
car02 = CargoTrain.new('car02')
car03 = CargoTrain.new('car03')
rt1 = Route.new('Kyiv - Lutsk', st1, st4)
rt1.add(st2, 2)
rt1.add(st3, 3)
rt2 = Route.new('Lutsk - Kyiv', st4, st1)
pas01.change(rt1)
pas02.change(rt1)
pas03.change(rt1)
car01.change(rt2)
car02.change(rt2)
car03.change(rt2)
PassengerTrain.all.each do |train|
  5.times { train.add(PassengerWagon.new(54)) }
end
CargoTrain.all.each do |train|
  5.times { train.add(CargoWagon.new(1000)) }
end
start = Menu.new
start.menu
