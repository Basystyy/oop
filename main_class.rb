require_relative './accessors'
class MyClass
  extend Accessors
  strong_attr_accessor :age
  attr_accessor_with_history :name, :number
end
