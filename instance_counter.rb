module InstanceCounter

  def self.included(base)
    base.extend Instances
    base.include Register
  end

  module Instances
    def instances
      self.class.amount
    end
  end

  module Register   
    @@amount = 0
    private
    def register_instance
      @@amount += 1
    end

  end

end