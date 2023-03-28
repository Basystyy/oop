# frozen_string_literal: true

module Accessors
  def strong_attr_accessor(name, type)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise 'Недопустимый тип данных!' if value.class != type
      instance_variable_set(var_name, value)
    end
    rescue StandardError => e
      puts "#{e} Значение не присвоено!"
  end

  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history ||= []
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        history << value
      end
      define_method("#{name}_history") { history }
    end
  end
end
