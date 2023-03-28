require_relative './accessors'
class MyClass
  extend Accessors
  strong_attr_accessor :age, Integer
  strong_attr_accessor :name, String
  attr_accessor_with_history :number
end
