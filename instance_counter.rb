# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def count_instances
      @@amount ||= 0
      @@amount += 1
    end

    def instances
      @@amount ||= 0
      @@amount
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.count_instances
    end
  end
end
