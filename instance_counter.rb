module InstanceCounter

  def self.included(base)
    base.extend Instances
    base.include Register
  end

  module Instances
    self.class.@@amount
  end

  module Register
    @@amount = 0

    protected
    
    def initialize
      super
      @@amount += 1
    end

  end

end