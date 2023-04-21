# frozen_string_literal: true

module Validate

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(variable, act, *arg)
      @validations ||= []
      @validations <<
        {
          var_name: variable,
          validation_type: act,
          params: arg
        }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        name = instance_variable_get("@#{validation[:var_name]}".to_sym)
        act = "v_#{validation[:validation_type]}".to_sym
        arg = validation[:params]
        result = public_send(act, name, arg)
        raise 'Действие недопустимо!' if result == false
      end
    end

    def v_presence(data, _params)
      !data.nil?
    end

    def v_format(data, params)
      data.match?(params[0])
    end

    def v_type(data, params)
      data.is_a?(params[0])
    end
  end
end