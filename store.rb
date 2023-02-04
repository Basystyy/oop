# frozen_string_literal: true

module Store
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def find(name)
      all.select { |object| object.name == name }
    end

    def add_object(name)
      @store ||= []
      @store << name
    end

    def all
      @store ||= []
      @store
    end
  end

  module InstanceMethods
    def valid?
      validate!
    rescue StandartError
      false
    end

    def added_object
      self.class.add_object(self)
    end
  end
end
