require_relative './accessors'
require_relative './validate'
class MyClass
  extend Accessors
  include Validate
  strong_attr_accessor :age, Integer
  strong_attr_accessor :name, String
  attr_accessor_with_history :number
  validate :name, :presence
  validate :age, :type, Integer
  validate :name, :format, /^[A-Z]*$/

  def initialize(name, age)
    @name = name
    @age = age

    validate!
  end
end
